Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230D71CA35F
	for <lists+linux-scsi@lfdr.de>; Fri,  8 May 2020 08:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgEHGAD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 May 2020 02:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgEHGAC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 May 2020 02:00:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64C1C05BD43
        for <linux-scsi@vger.kernel.org>; Thu,  7 May 2020 23:00:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 6AF672A0457
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     lduncan@suse.com
Cc:     cleech@redhat.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH] iscsi: Fix deadlock on recovery path during GFP_IO reclaim
Date:   Fri,  8 May 2020 01:59:54 -0400
Message-Id: <20200508055954.843165-1-krisman@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

iscsi suffers from a deadlock in case a management command submitted via
the netlink socket sleeps on an allocation while holding the
rx_queue_mutex, if that allocation causes a memory reclaim that
writebacks to a failed iscsi device.  Then, the recovery procedure can
never make progress to recover the failed disk or abort outstanding IO
operations to complete the reclaim (since rx_queue_mutex is locked),
thus locking the system.

Nevertheless, just marking all allocations under rx_queue_mutex as
GFP_NOIO (or locking the userspace process with something like
PF_MEMALLOC_NOIO) is not enough, since the iscsi command code relies on
other subsystems that try to grab locked mutexes, whose threads are
GFP_IO, leading to the same deadlock. One instance where this situation
can be observed is in the backtraces below, stitched from multiple bugs
reports, involving the kobj uevent sent when a session is created.

The root of the problem is not the fact that iscsi does GFP_IO
allocations, that is acceptable. The actual problem is that
rx_queue_mutex has a very large granularity, covering every unrelated
netlink command execution at the same time as the error recovery path.

The proposed fix leverages the recently added mechanism to stop failed
connections from the kernel, by enabling it to execute even though a
management command from the netlink socket is being run (rx_queue_mutex
is held), provided that the command is known to be safe.  It splits the
rx_queue_mutex in two mutexes, one protecting from concurrent command
execution from the netlink socket, and one protecting stop_conn from
racing with other connection management operations that might conflict
with it.

It is not very pretty, but it is the simplest way to resolve the
deadlock.  I considered making it a lock per connection, but some
external mutex would still be needed to deal with iscsi_if_destroy_conn.

The patch was tested by forcing a memory shrinker (unrelated, but used
bufio/dm-verity) to reclaim ISCSI pages every time
ISCSI_UEVENT_CREATE_SESSION happens, which is reasonable to simulate
reclaims that might happen with GFP_KERNEL on that path.  Then, a faulty
hung target causes a connection to fail during intensive IO, at the same
time a new session is added by iscsid.

The following stacktraces are stiches from several bug reports, showing
a case where the deadlock can happen.

 iSCSI-write
         holding: rx_queue_mutex
         waiting: uevent_sock_mutex

         kobject_uevent_env+0x1bd/0x419
         kobject_uevent+0xb/0xd
         device_add+0x48a/0x678
         scsi_add_host_with_dma+0xc5/0x22d
         iscsi_host_add+0x53/0x55
         iscsi_sw_tcp_session_create+0xa6/0x129
         iscsi_if_rx+0x100/0x1247
         netlink_unicast+0x213/0x4f0
         netlink_sendmsg+0x230/0x3c0

 iscsi_fail iscsi_conn_failure
         waiting: rx_queue_mutex

         schedule_preempt_disabled+0x325/0x734
         __mutex_lock_slowpath+0x18b/0x230
         mutex_lock+0x22/0x40
         iscsi_conn_failure+0x42/0x149
         worker_thread+0x24a/0xbc0

 EventManager_
         holding: uevent_sock_mutex
         waiting: dm_bufio_client->lock

         dm_bufio_lock+0xe/0x10
         shrink+0x34/0xf7
         shrink_slab+0x177/0x5d0
         do_try_to_free_pages+0x129/0x470
         try_to_free_mem_cgroup_pages+0x14f/0x210
         memcg_kmem_newpage_charge+0xa6d/0x13b0
         __alloc_pages_nodemask+0x4a3/0x1a70
         fallback_alloc+0x1b2/0x36c
         __kmalloc_node_track_caller+0xb9/0x10d0
         __alloc_skb+0x83/0x2f0
         kobject_uevent_env+0x26b/0x419
         dm_kobject_uevent+0x70/0x79
         dev_suspend+0x1a9/0x1e7
         ctl_ioctl+0x3e9/0x411
         dm_ctl_ioctl+0x13/0x17
         do_vfs_ioctl+0xb3/0x460
         SyS_ioctl+0x5e/0x90

 MemcgReclaimerD"
         holding: dm_bufio_client->lock
         waiting: stuck io to finish (needs iscsi_fail thread to progress)

         schedule at ffffffffbd603618
         io_schedule at ffffffffbd603ba4
         do_io_schedule at ffffffffbdaf0d94
         __wait_on_bit at ffffffffbd6008a6
         out_of_line_wait_on_bit at ffffffffbd600960
         wait_on_bit.constprop.10 at ffffffffbdaf0f17
         __make_buffer_clean at ffffffffbdaf18ba
         __cleanup_old_buffer at ffffffffbdaf192f
         shrink at ffffffffbdaf19fd
         do_shrink_slab at ffffffffbd6ec000
         shrink_slab at ffffffffbd6ec24a
         do_try_to_free_pages at ffffffffbd6eda09
         try_to_free_mem_cgroup_pages at ffffffffbd6ede7e
         mem_cgroup_resize_limit at ffffffffbd7024c0
         mem_cgroup_write at ffffffffbd703149
         cgroup_file_write at ffffffffbd6d9c6e
         sys_write at ffffffffbd6662ea
         system_call_fastpath at ffffffffbdbc34a2

Reported-by: Khazhismel Kumykov <khazhy@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 67 +++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 17a45716a0fe..d99c17306dff 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1616,6 +1616,12 @@ static DECLARE_TRANSPORT_CLASS(iscsi_connection_class,
 static struct sock *nls;
 static DEFINE_MUTEX(rx_queue_mutex);
 
+/*
+ * conn_mutex protects the {start,bind,stop,destroy}_conn from racing
+ * against the kernel stop_connection recovery mechanism
+ */
+static DEFINE_MUTEX(conn_mutex);
+
 static LIST_HEAD(sesslist);
 static LIST_HEAD(sessdestroylist);
 static DEFINE_SPINLOCK(sesslock);
@@ -2442,6 +2448,32 @@ int iscsi_offload_mesg(struct Scsi_Host *shost,
 }
 EXPORT_SYMBOL_GPL(iscsi_offload_mesg);
 
+/*
+ * This can be called without the rx_queue_mutex, if invoked by the kernel
+ * stop work. But, in that case, it is guaranteed not to race with
+ * iscsi_destroy by conn_mutex.
+ */
+static void iscsi_if_stop_conn(struct iscsi_cls_conn *conn, int flag)
+{
+	/*
+	 * It is important that this path doesn't rely on
+	 * rx_queue_mutex, otherwise, a thread doing allocation on a
+	 * start_session/start_connection could sleep waiting on a
+	 * writeback to a failed iscsi device, that cannot be recovered
+	 * because the lock is held.  If we don't hold it here, the
+	 * kernel stop_conn_work_fn has a chance to stop the broken
+	 * session and resolve the allocation.
+	 *
+	 * Still, the user invoked .stop_conn() needs to be serialized
+	 * with stop_conn_work_fn by a private mutex.  Not pretty, but
+	 * it works.
+	 */
+	mutex_lock(&conn_mutex);
+	conn->transport->stop_conn(conn, flag);
+	mutex_unlock(&conn_mutex);
+
+}
+
 static void stop_conn_work_fn(struct work_struct *work)
 {
 	struct iscsi_cls_conn *conn, *tmp;
@@ -2460,30 +2492,17 @@ static void stop_conn_work_fn(struct work_struct *work)
 		uint32_t sid = iscsi_conn_get_sid(conn);
 		struct iscsi_cls_session *session;
 
-		mutex_lock(&rx_queue_mutex);
-
 		session = iscsi_session_lookup(sid);
 		if (session) {
 			if (system_state != SYSTEM_RUNNING) {
 				session->recovery_tmo = 0;
-				conn->transport->stop_conn(conn,
-							   STOP_CONN_TERM);
+				iscsi_if_stop_conn(conn, STOP_CONN_TERM);
 			} else {
-				conn->transport->stop_conn(conn,
-							   STOP_CONN_RECOVER);
+				iscsi_if_stop_conn(conn, STOP_CONN_RECOVER);
 			}
 		}
 
 		list_del_init(&conn->conn_list_err);
-
-		mutex_unlock(&rx_queue_mutex);
-
-		/* we don't want to hold rx_queue_mutex for too long,
-		 * for instance if many conns failed at the same time,
-		 * since this stall other iscsi maintenance operations.
-		 * Give other users a chance to proceed.
-		 */
-		cond_resched();
 	}
 }
 
@@ -2843,8 +2862,11 @@ iscsi_if_destroy_conn(struct iscsi_transport *transport, struct iscsi_uevent *ev
 	spin_unlock_irqrestore(&connlock, flags);
 
 	ISCSI_DBG_TRANS_CONN(conn, "Destroying transport conn\n");
+
+	mutex_lock(&conn_mutex);
 	if (transport->destroy_conn)
 		transport->destroy_conn(conn);
+	mutex_unlock(&conn_mutex);
 
 	return 0;
 }
@@ -3686,9 +3708,12 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 			break;
 		}
 
+		mutex_lock(&conn_mutex);
 		ev->r.retcode =	transport->bind_conn(session, conn,
 						ev->u.b_conn.transport_eph,
 						ev->u.b_conn.is_leading);
+		mutex_unlock(&conn_mutex);
+
 		if (ev->r.retcode || !transport->ep_connect)
 			break;
 
@@ -3709,25 +3734,31 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 		break;
 	case ISCSI_UEVENT_START_CONN:
 		conn = iscsi_conn_lookup(ev->u.start_conn.sid, ev->u.start_conn.cid);
-		if (conn)
+		if (conn) {
+			mutex_lock(&conn_mutex);
 			ev->r.retcode = transport->start_conn(conn);
+			mutex_unlock(&conn_mutex);
+		}
 		else
 			err = -EINVAL;
 		break;
 	case ISCSI_UEVENT_STOP_CONN:
 		conn = iscsi_conn_lookup(ev->u.stop_conn.sid, ev->u.stop_conn.cid);
 		if (conn)
-			transport->stop_conn(conn, ev->u.stop_conn.flag);
+			iscsi_if_stop_conn(conn, ev->u.stop_conn.flag);
 		else
 			err = -EINVAL;
 		break;
 	case ISCSI_UEVENT_SEND_PDU:
 		conn = iscsi_conn_lookup(ev->u.send_pdu.sid, ev->u.send_pdu.cid);
-		if (conn)
+		if (conn) {
+			mutex_lock(&conn_mutex);
 			ev->r.retcode =	transport->send_pdu(conn,
 				(struct iscsi_hdr*)((char*)ev + sizeof(*ev)),
 				(char*)ev + sizeof(*ev) + ev->u.send_pdu.hdr_size,
 				ev->u.send_pdu.data_size);
+			mutex_unlock(&conn_mutex);
+		}
 		else
 			err = -EINVAL;
 		break;
-- 
2.26.2

