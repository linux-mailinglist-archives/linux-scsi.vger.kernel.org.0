Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40A48E0D4
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jan 2022 00:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiAMXZ0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jan 2022 18:25:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235310AbiAMXZZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 13 Jan 2022 18:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642116324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/cYjdYc1cOu2NaGMgT2On4jE9UFJ7SNdWKgu/5ofk7U=;
        b=hjHdGyk7Bk3gEdwJQrys2TNLZljqpAvByHzZa+mPduYomFtChlNmNr21eJywMgZSPaNsAF
        hZzCDQlTXB+7r95ZFud7Z6GuCtULzaCKJo5IrIN3XNHZoWYXA0pxx7mevTVYVs5lYL9mQN
        aW2pUtYGngjQhv7wx9oJ6jPZ7e5Hv+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-R0N9NBi0MV28KfAFG6CeqQ-1; Thu, 13 Jan 2022 18:25:21 -0500
X-MC-Unique: R0N9NBi0MV28KfAFG6CeqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F1121083F66;
        Thu, 13 Jan 2022 23:25:20 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E87F1042A9C;
        Thu, 13 Jan 2022 23:25:14 +0000 (UTC)
From:   John Meneghini <jmeneghi@redhat.com>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com, mlombard@redhat.com,
        skashyap@marvell.com
Subject: [PATCH] scsi: bnx2fc: flush destroy_work queue before calling bnx2fc_interface_put
Date:   Thu, 13 Jan 2022 18:24:56 -0500
Message-Id: <20220113232456.230749-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

  The bnx2fc_destroy functions are removing the interface before calling
  destroy_work. This results multiple WARNings from sysfs_remove_group
  as the controller rport device attributes are removed to early.

  The problem is easily reproducible with the following steps.

  Example:

    $ dmesg -w &
    $ systemctl enable --now fcoe
    $ fipvlan -s -c ens2f1
    $ fcoeadm -d ens2f1.802
    [  583.464488] host2: libfc: Link down on port (7500a1)
    [  583.472651] bnx2fc: 7500a1 - rport not created Yet!!
    [  583.490468] ------------[ cut here ]------------
    [  583.538725] sysfs group 'power' not found for kobject 'rport-2:0-0'
    [  583.568814] WARNING: CPU: 3 PID: 192 at fs/sysfs/group.c:279 sysfs_remove_group+0x6f/0x80
    [  583.607130] Modules linked in: dm_service_time 8021q garp mrp stp llc bnx2fc cnic uio rpcsec_gss_krb5 auth_rpcgss nfsv4 ...
    [  583.942994] CPU: 3 PID: 192 Comm: kworker/3:2 Kdump: loaded Not tainted 5.14.0-39.el9.x86_64 #1
    [  583.984105] Hardware name: HP ProLiant DL120 G7, BIOS J01 07/01/2013
    [  584.016535] Workqueue: fc_wq_2 fc_rport_final_delete [scsi_transport_fc]
    [  584.050691] RIP: 0010:sysfs_remove_group+0x6f/0x80
    [  584.074725] Code: ff 5b 48 89 ef 5d 41 5c e9 ee c0 ff ff 48 89 ef e8 f6 b8 ff ff eb d1 49 8b 14 24 48 8b 33 48 c7 c7 ...
    [  584.162586] RSP: 0018:ffffb567c15afdc0 EFLAGS: 00010282
    [  584.188225] RAX: 0000000000000000 RBX: ffffffff8eec4220 RCX: 0000000000000000
    [  584.221053] RDX: ffff8c1586ce84c0 RSI: ffff8c1586cd7cc0 RDI: ffff8c1586cd7cc0
    [  584.255089] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffb567c15afc00
    [  584.287954] R10: ffffb567c15afbf8 R11: ffffffff8fbe7f28 R12: ffff8c1486326400
    [  584.322356] R13: ffff8c1486326480 R14: ffff8c1483a4a000 R15: 0000000000000004
    [  584.355379] FS:  0000000000000000(0000) GS:ffff8c1586cc0000(0000) knlGS:0000000000000000
    [  584.394419] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  584.421123] CR2: 00007fe95a6f7840 CR3: 0000000107674002 CR4: 00000000000606e0
    [  584.454888] Call Trace:
    [  584.466108]  device_del+0xb2/0x3e0
    [  584.481701]  device_unregister+0x13/0x60
    [  584.501306]  bsg_unregister_queue+0x5b/0x80
    [  584.522029]  bsg_remove_queue+0x1c/0x40
    [  584.541884]  fc_rport_final_delete+0xf3/0x1d0 [scsi_transport_fc]
    [  584.573823]  process_one_work+0x1e3/0x3b0
    [  584.592396]  worker_thread+0x50/0x3b0
    [  584.609256]  ? rescuer_thread+0x370/0x370
    [  584.628877]  kthread+0x149/0x170
    [  584.643673]  ? set_kthread_struct+0x40/0x40
    [  584.662909]  ret_from_fork+0x22/0x30
    [  584.680002] ---[ end trace 53575ecefa942ece ]---

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 71fa62bd3083..6e7e40e8ce4a 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -1215,8 +1215,10 @@ static int bnx2fc_vport_destroy(struct fc_vport *vport)
 	mutex_unlock(&n_port->lp_mutex);
 	bnx2fc_free_vport(interface->hba, port->lport);
 	bnx2fc_port_shutdown(port->lport);
-	bnx2fc_interface_put(interface);
 	queue_work(bnx2fc_wq, &port->destroy_work);
+	flush_work(&port->destroy_work);
+	bnx2fc_interface_put(interface);
+
 	return 0;
 }
 
@@ -1653,8 +1655,9 @@ static void __bnx2fc_destroy(struct bnx2fc_interface *interface)
 	bnx2fc_interface_cleanup(interface);
 	bnx2fc_stop(interface);
 	list_del(&interface->list);
-	bnx2fc_interface_put(interface);
 	queue_work(bnx2fc_wq, &port->destroy_work);
+	flush_work(&port->destroy_work);
+	bnx2fc_interface_put(interface);
 }
 
 /**
-- 
2.27.0

