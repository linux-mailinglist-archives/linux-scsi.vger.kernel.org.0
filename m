Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0F17C6A9
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Mar 2020 20:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCFT7J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 Mar 2020 14:59:09 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41552 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFT7I (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 Mar 2020 14:59:08 -0500
Received: from localhost (unknown [IPv6:2610:98:8005::787])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BBB1729714D;
        Fri,  6 Mar 2020 19:59:06 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     open-iscsi@googlegroups.com, lduncan@suse.com, cleech@redhat.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Junho Ryu <jayr@google.com>
Subject: Re: [PATCH v2] iscsi: Report connection state on sysfs
Organization: Collabora
References: <20200305153521.1374259-1-krisman@collabora.com>
        <bc70bd6d-6d13-4d1c-8559-140411e361d9@acm.org>
        <854kv2bobx.fsf@collabora.com>
        <b2b62579-b2b6-b797-501b-186ac24df399@acm.org>
Date:   Fri, 06 Mar 2020 14:59:03 -0500
In-Reply-To: <b2b62579-b2b6-b797-501b-186ac24df399@acm.org> (Bart Van Assche's
        message of "Thu, 5 Mar 2020 13:16:08 -0800")
Message-ID: <85h7z12r20.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> writes:

> How about removing the loop as follows?
>

Hey, Thanks for the review.

I understand designated initializers :-P

My point was following the pattern of the other statuses sysfs files in
the iSCSI layer.

But, I really don't mind.  What do you think of v3 below?

-- >8 --
Subject: [PATCH v3] iscsi: Report connection state on sysfs

If an iSCSI connection happens to fail while the daemon isn't
running (due to a crash or for another reason), the kernel failure
report is not received.  When the daemon restarts, there is insufficient
kernel state in sysfs for it to know that this happened.  open-iscsi
tries to reopen every connection, but on different initiators, we'd like
to know which connections have failed.

There is session->state, but that has a different lifetime than an iSCSI
connection, so it doesn't directly relflect the connection state.

Cc: Khazhismel Kumykov <khazhy@google.com>
Suggested-by: Junho Ryu <jayr@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
Changes since v2:
  - Use designated initializers (Bart)

Changes since v1:
  - Remove dependency of state values (Bart)


 drivers/scsi/libiscsi.c             |  7 ++++++-
 drivers/scsi/scsi_transport_iscsi.c | 28 +++++++++++++++++++++++++++-
 include/scsi/scsi_transport_iscsi.h |  8 ++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 70b99c0e2e67..ca488c57ead4 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3153,13 +3153,18 @@ void iscsi_conn_stop(struct iscsi_cls_conn *cls_conn, int flag)
 
 	switch (flag) {
 	case STOP_CONN_RECOVER:
+		cls_conn->state = ISCSI_CONN_FAILED;
+		break;
 	case STOP_CONN_TERM:
-		iscsi_start_session_recovery(session, conn, flag);
+		cls_conn->state = ISCSI_CONN_DOWN;
 		break;
 	default:
 		iscsi_conn_printk(KERN_ERR, conn,
 				  "invalid stop flag %d\n", flag);
+		return;
 	}
+
+	iscsi_start_session_recovery(session, conn, flag);
 }
 EXPORT_SYMBOL_GPL(iscsi_conn_stop);
 
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 17a45716a0fe..e2a9d48e3d8e 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2276,6 +2276,7 @@ iscsi_create_conn(struct iscsi_cls_session *session, int dd_size, uint32_t cid)
 	INIT_LIST_HEAD(&conn->conn_list_err);
 	conn->transport = transport;
 	conn->cid = cid;
+	conn->state = ISCSI_CONN_DOWN;
 
 	/* this is released in the dev's release function */
 	if (!get_device(&session->dev))
@@ -3709,8 +3710,11 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 		break;
 	case ISCSI_UEVENT_START_CONN:
 		conn = iscsi_conn_lookup(ev->u.start_conn.sid, ev->u.start_conn.cid);
-		if (conn)
+		if (conn) {
 			ev->r.retcode = transport->start_conn(conn);
+			if (!ev->r.retcode)
+				conn->state = ISCSI_CONN_UP;
+		}
 		else
 			err = -EINVAL;
 		break;
@@ -3907,6 +3911,25 @@ iscsi_conn_attr(tcp_xmit_wsf, ISCSI_PARAM_TCP_XMIT_WSF);
 iscsi_conn_attr(tcp_recv_wsf, ISCSI_PARAM_TCP_RECV_WSF);
 iscsi_conn_attr(local_ipaddr, ISCSI_PARAM_LOCAL_IPADDR);
 
+static const char *const connection_state_names[] = {
+	[ISCSI_CONN_UP] = "up",
+	[ISCSI_CONN_DOWN] = "down",
+	[ISCSI_CONN_FAILED] = "failed"
+};
+
+static ssize_t show_conn_state(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct iscsi_cls_conn *conn = iscsi_dev_to_conn(dev->parent);
+	const char *state = "unknown";
+
+	if (conn->state < ARRAY_SIZE(connection_state_names))
+		state = connection_state_names[conn->state];
+
+	return sprintf(buf, "%s\n", state);
+}
+static ISCSI_CLASS_ATTR(conn, state, S_IRUGO, show_conn_state,
+			NULL);
 
 #define iscsi_conn_ep_attr_show(param)					\
 static ssize_t show_conn_ep_param_##param(struct device *dev,		\
@@ -3976,6 +3999,7 @@ static struct attribute *iscsi_conn_attrs[] = {
 	&dev_attr_conn_tcp_xmit_wsf.attr,
 	&dev_attr_conn_tcp_recv_wsf.attr,
 	&dev_attr_conn_local_ipaddr.attr,
+	&dev_attr_conn_state.attr,
 	NULL,
 };
 
@@ -4047,6 +4071,8 @@ static umode_t iscsi_conn_attr_is_visible(struct kobject *kobj,
 		param = ISCSI_PARAM_TCP_RECV_WSF;
 	else if (attr == &dev_attr_conn_local_ipaddr.attr)
 		param = ISCSI_PARAM_LOCAL_IPADDR;
+	else if (attr == &dev_attr_conn_state.attr)
+		return S_IRUGO;
 	else {
 		WARN_ONCE(1, "Invalid conn attr");
 		return 0;
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index fa8814245796..1b8a07b427a3 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -188,6 +188,13 @@ extern void iscsi_ping_comp_event(uint32_t host_no,
 				  uint32_t status, uint32_t pid,
 				  uint32_t data_size, uint8_t *data);
 
+/* iscsi class connection state */
+enum {
+	ISCSI_CONN_UP = 0,
+	ISCSI_CONN_DOWN,
+	ISCSI_CONN_FAILED,
+};
+
 struct iscsi_cls_conn {
 	struct list_head conn_list;	/* item in connlist */
 	struct list_head conn_list_err;	/* item in connlist_err */
@@ -198,6 +205,7 @@ struct iscsi_cls_conn {
 	struct iscsi_endpoint *ep;
 
 	struct device dev;		/* sysfs transport/container device */
+	unsigned int state;
 };
 
 #define iscsi_dev_to_conn(_dev) \
-- 
2.25.0



