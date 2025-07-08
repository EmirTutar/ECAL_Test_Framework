# RPC Reconnect Test

## Objective

This test verifies whether an eCAL RPC client can recover from a network disconnection
and successfully reconnect to the RPC server.

It validates that two RPC calls ("Ping") succeed — one before and one after the disconnect.

---

## Test Setup

### Components

| Component   | Role      | Mode        | Method | Request | Expected Response |
|-------------|-----------|-------------|--------|---------|-------------------|
| RPC Server  | Responder | Network UDP | Ping   | "PING"  | "PONG"            |
| RPC Client  | Caller    | Network UDP | Ping   | "PING"  | "PONG"            |

### Communication (before and after disconnect)

```
Step 1: Initial RPC Call
+-------------+         Request: "PING"         +-------------+
| RPC Client  | ------------------------------> | RPC Server  |
|             | <------------------------------ |             |
|             |         Response: "PONG"        |             |
+-------------+                                 +-------------+

[Network Disconnect / Reconnect]

Step 2: Second RPC Call (after reconnect)
+-------------+         Request: "PING"         +-------------+
| RPC Client  | ------------------------------> | RPC Server  |
|             | <------------------------------ |             |
|             |         Response: "PONG"        |             |
+-------------+                                 +-------------+
```

---

## Test Flow

1. Start the RPC Server and Client in fixed-IP Docker containers on a custom subnet.
2. Client sends an initial `Ping`, waits for `PONG`.
3. The network connection is removed from the client container.
4. After a short delay, the client is reconnected to the same network and IP.
5. Client attempts a second `Ping`.
6. Client exits with code 0 only if both responses are `"PONG"`.

---

## Pass Criteria

- Server receives two requests and responds with `"PONG"` both times.
- Client successfully receives both `"PONG"` responses.
- Client exits with code `0`.

---

## Folder Structure

```
rpc_reconnect_test/
├── docker/
│   └── Dockerfile
├── robottests/
│   └── rpc_reconnect_test.robot
├── scripts/
│   ├── build_images.sh
│   └── entrypoint.sh
├── src/
│   ├── rpc_ping_server.cpp
│   └── rpc_ping_client.cpp
└── README.txt
```

---

## Run the Test

```bash
robot robottests/rpc_reconnect_test.robot
```

---

## Notes

This test ensures that eCAL services using network UDP can recover from temporary disconnections.

---

## Why Fixed IPs?

The issue is likely caused by how multicast communication via UDP behaves when containers are disconnected and reconnected.

### Background

eCAL uses UDP multicast for `network_udp` communication.

1. When disconnecting a container from the Docker network:
   - It loses multicast group membership.
   - It loses connection to the eCAL registration service (broadcast/multicast).

2. After reconnecting:
   - The container might get a new IP address, which the server no longer recognizes.
   - Multicast sockets are not re-established automatically.
   - The client may believe it's connected, but the server doesn't recognize it (or vice versa).

**Fix:** Assigning a fixed IP and rejoining the same network ensures consistent addressing and multicast re-registration.