Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E26350492
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 10:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfFXIaJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 04:30:09 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56732 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726612AbfFXIaJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 Jun 2019 04:30:09 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O8U2Ts025408
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=fQMvga80lf5wMRsR2hyk4X+vIG9cDlUmukMEWoREf1w=;
 b=CTP2QS+mDchk/zXwCxGD92eWxlB/ltB7TE56iBySrzs6ShrEoVukWf4/vgE2WpXmLXWk
 TC/fgfgY3eH9zuv29ZU+sJKt//YbFoT5tP4Fgpw3vRl/Wg8JWFg0qg1o2TNlQGOQ2wHe
 ecWKoVGWKmX2nWrcpD4bgcD7pVBpeXzu7nsTtsvXAKy0pX69ZirTnooQd8PRHsIUBsYr
 DiGmUgoYt02eLGUTRCX5ETxlE6oDo8Zbtlc3wm5zlLjDnna5XVbqfDyRrn7GL0wq/uIl
 J1C/U/JWrNVt7uix3fkyvImXKqV6/oeTJjhWuHQSJJM2BZ0uzD+6DPxELmFzrAE+YtIy iQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tarxr8dp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 01:30:08 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 01:30:07 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 24 Jun 2019 01:30:07 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 89D933F7041;
        Mon, 24 Jun 2019 01:30:07 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5O8U7Nm023219;
        Mon, 24 Jun 2019 01:30:07 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x5O8U7ch023218;
        Mon, 24 Jun 2019 01:30:07 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 2/6] bnx2fc: Only put reference to io_req in bnx2fc_abts_cleanup if cleanup times out.
Date:   Mon, 24 Jun 2019 01:29:56 -0700
Message-ID: <20190624083000.23074-3-skashyap@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190624083000.23074-1-skashyap@marvell.com>
References: <20190624083000.23074-1-skashyap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Chad Dupuis <cdupuis@marvell.com>

In certain tests where the SCSI error handler issues an abort that is
already outstanding we will cleanup the command so that the SCSI error
handler can proceed.  In some of these cases we were seeing a command
mismatch:

 kernel: scsi host2: bnx2fc: xid:0x42b eh_abort - refcnt = 2
 kernel: bnx2fc: eh_abort: io_req (xid = 0x42b) already in abts processing
 kernel: scsi host2: bnx2fc: xid:0x42b Entered bnx2fc_initiate_cleanup
 kernel: scsi host2: bnx2fc: xid:0x42b CLEANUP io_req xid = 0x80b
 kernel: scsi host2: bnx2fc: xid:0x80b cq_compl- cleanup resp rcvd
 kernel: scsi host2: bnx2fc: xid:0x42b complete - rx_state = 9
 kernel: scsi host2: bnx2fc: xid:0x42b Entered process_cleanup_compl refcnt = 2, cmd_type = 1
 kernel: scsi host2: bnx2fc: xid:0x42b scsi_done. err_code = 0x7
 kernel: scsi host2: bnx2fc: xid:0x42b sc=ffff8807f93dfb80, result=0x7, retries=0, allowed=5
 kernel: ------------[ cut here ]------------
 kernel: WARNING: at /root/rpmbuild/BUILD/netxtreme2-7.14.43/obj/default/bnx2fc-2.12.1/driver/bnx2fc_io.c:1347 bnx2fc_eh_abort+0x56f/0x680 [bnx2fc]()
 kernel: xid=0x42b refcount=-1
 kernel: Modules linked in:
 kernel: nls_utf8 isofs sr_mod cdrom tcp_lp dm_round_robin xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 tun bridge ebtable_filter ebtables fuse ip6table_filter ip6_tables iptable_filter bnx2fc(OE) cnic(OE) uio fcoe libfcoe 8021q libfc garp mrp scsi_transport_fc stp llc scsi_tgt vfat fat dm_service_time intel_powerclamp coretemp intel_rapl iosf_mbi kvm_intel kvm irqbypass crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper ablk_helper cryptd ses enclosure ipmi_ssif i2c_core hpilo hpwdt wmi sg ipmi_devintf pcspkr ipmi_si ipmi_msghandler shpchp acpi_power_meter dm_multipath nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs sd_mod crc_t10dif
 kernel: crct10dif_generic bnx2x(OE) crct10dif_pclmul crct10dif_common crc32c_intel mdio ptp pps_core libcrc32c smartpqi scsi_transport_sas fjes uas usb_storage dm_mirror dm_region_hash dm_log dm_mod
 kernel: CPU: 9 PID: 2012 Comm: scsi_eh_2 Tainted: G        W  OE  ------------   3.10.0-514.el7.x86_64 #1
 kernel: Hardware name: HPE Synergy 480 Gen10/Synergy 480 Gen10 Compute Module, BIOS I42 03/21/2018
 kernel: ffff8807f25a3d98 0000000015e7fa0c ffff8807f25a3d50 ffffffff81685eac
 kernel: ffff8807f25a3d88 ffffffff81085820 ffff8807f8e39000 ffff880801ff7468
 kernel: ffff880801ff7610 0000000000002002 ffff8807f8e39014 ffff8807f25a3df0
 kernel: Call Trace:
 kernel: [<ffffffff81685eac>] dump_stack+0x19/0x1b
 kernel: [<ffffffff81085820>] warn_slowpath_common+0x70/0xb0
 kernel: [<ffffffff810858bc>] warn_slowpath_fmt+0x5c/0x80
 kernel: [<ffffffff8168d842>] ? _raw_spin_lock_bh+0x12/0x50
 kernel: [<ffffffffa0549e6f>] bnx2fc_eh_abort+0x56f/0x680 [bnx2fc]
 kernel: [<ffffffff814570af>] scsi_error_handler+0x59f/0x8b0
 kernel: [<ffffffff81456b10>] ? scsi_eh_get_sense+0x250/0x250
 kernel: [<ffffffff810b052f>] kthread+0xcf/0xe0
 kernel: [<ffffffff810b0460>] ? kthread_create_on_node+0x140/0x140
 kernel: [<ffffffff81696418>] ret_from_fork+0x58/0x90
 kernel: [<ffffffff810b0460>] ? kthread_create_on_node+0x140/0x140
 kernel: ---[ end trace 42deb88f2032b111 ]---

The reason that there was a mismatch is that the SCSI command is actual
returned from the cleanup handler.  In previous testing, the type of
cleanup notification we'd get from the CQE did not trigger the code that
returned the SCSI command.  To overcome the previous behavior we would put
a reference in bnx2fc_abts_cleanup() to account for the SCSI command.
However in cases where the SCSI command is actually off we end up with an
extra put.

The fix for this is to only take the extra put in bnx2fc_abts_cleanup if
the completion for the cleanup times out.

Signed-off-by: Chad Dupuis <cdupuis@marvell.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/bnx2fc/bnx2fc_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 8def63c..578ff53 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -1097,16 +1097,16 @@ static int bnx2fc_abts_cleanup(struct bnx2fc_cmd *io_req)
 	time_left = wait_for_completion_timeout(&io_req->tm_done,
 						BNX2FC_FW_TIMEOUT);
 	io_req->wait_for_comp = 0;
-	if (!time_left)
+	if (!time_left) {
 		BNX2FC_IO_DBG(io_req, "%s(): Wait for cleanup timed out.\n",
 			      __func__);
 
-	/*
-	 * Release reference held by SCSI command the cleanup completion
-	 * hits the BNX2FC_CLEANUP case in bnx2fc_process_cq_compl() and
-	 * thus the SCSI command is not returnedi by bnx2fc_scsi_done().
-	 */
-	kref_put(&io_req->refcount, bnx2fc_cmd_release);
+		/*
+		 * Put the extra reference to the SCSI command since it would
+		 * not have been returned in this case.
+		 */
+		kref_put(&io_req->refcount, bnx2fc_cmd_release);
+	}
 
 	spin_lock_bh(&tgt->tgt_lock);
 	return SUCCESS;
-- 
1.8.3.1

