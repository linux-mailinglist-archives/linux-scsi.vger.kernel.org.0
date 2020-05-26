Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE98B1B2ACB
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2020 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDUPOm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 Apr 2020 11:14:42 -0400
Received: from smtp.infotech.no ([82.134.31.41]:41939 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgDUPOl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 21 Apr 2020 11:14:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id B702E204259;
        Tue, 21 Apr 2020 17:14:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pP5gwWGy19sg; Tue, 21 Apr 2020 17:14:37 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-23-251-188-50.dyn.295.ca [23.251.188.50])
        by smtp.infotech.no (Postfix) with ESMTPA id 54F2E204258;
        Tue, 21 Apr 2020 17:14:34 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        Damien.LeMoal@wdc.com
Subject: [PATCH v5 3/8] scsi_debug: implement verify(10), add verify(16)
Date:   Tue, 21 Apr 2020 11:14:19 -0400
Message-Id: <20200421151424.32668-4-dgilbert@interlog.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421151424.32668-1-dgilbert@interlog.com>
References: <20200421151424.32668-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

With the addition of the per_host_store option, the ability to check
whether two different ramdisk images are the same or not becomes
practical. Prior to this patch VERIFY(10) always returned true (i.e.
the SCSI GOOD status) without checking. This option adds support for
BYTCHK equal to 0, 1 and 3 . If the comparison fails then a sense
key of MISCOMPARE is returned as per the T10 standards. Add support
for the VERIFY(16).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 101 +++++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index af2eaf6dd64f..cc6375a3c2ad 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -354,7 +354,7 @@ enum sdeb_opcode_index {
 	SDEB_I_SERV_ACT_OUT_16 = 13,	/* add ...SERV_ACT_OUT_12 if needed */
 	SDEB_I_MAINT_IN = 14,
 	SDEB_I_MAINT_OUT = 15,
-	SDEB_I_VERIFY = 16,		/* 10 only */
+	SDEB_I_VERIFY = 16,		/* VERIFY(10), VERIFY(16) */
 	SDEB_I_VARIABLE_LEN = 17,	/* READ(32), WRITE(32), WR_SCAT(32) */
 	SDEB_I_RESERVE = 18,		/* 6, 10 */
 	SDEB_I_RELEASE = 19,		/* 6, 10 */
@@ -397,7 +397,8 @@ static const unsigned char opcode_ind_arr[256] = {
 	0, SDEB_I_VARIABLE_LEN,
 /* 0x80; 0x80->0x9f: 16 byte cdbs */
 	0, 0, 0, 0, 0, SDEB_I_ATA_PT, 0, 0,
-	SDEB_I_READ, SDEB_I_COMP_WRITE, SDEB_I_WRITE, 0, 0, 0, 0, 0,
+	SDEB_I_READ, SDEB_I_COMP_WRITE, SDEB_I_WRITE, 0,
+	0, 0, 0, SDEB_I_VERIFY,
 	0, SDEB_I_SYNC_CACHE, 0, SDEB_I_WRITE_SAME, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, SDEB_I_SERV_ACT_IN_16, SDEB_I_SERV_ACT_OUT_16,
 /* 0xa0; 0xa0->0xbf: 12 byte cdbs */
@@ -439,6 +440,7 @@ static int resp_report_tgtpgs(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_unmap(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_rsup_opcodes(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_rsup_tmfs(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_verify(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_write_same_10(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_write_same_16(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_comp_write(struct scsi_cmnd *, struct sdebug_dev_info *);
@@ -490,6 +492,12 @@ static const struct opcode_info_t write_iarr[] = {
 		   0xbf, 0xc7, 0, 0, 0, 0} },
 };
 
+static const struct opcode_info_t verify_iarr[] = {
+	{0, 0x2f, 0, F_D_OUT_MAYBE | FF_MEDIA_IO, resp_verify,/* VERIFY(10) */
+	    NULL, {10,  0xf7, 0xff, 0xff, 0xff, 0xff, 0xbf, 0xff, 0xff, 0xc7,
+		   0, 0, 0, 0, 0, 0} },
+};
+
 static const struct opcode_info_t sa_in_16_iarr[] = {
 	{0, 0x9e, 0x12, F_SA_LOW | F_D_IN, resp_get_lba_status, NULL,
 	    {16,  0x12, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
@@ -590,9 +598,10 @@ static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEMENT + 1] = {
 /* 15 */
 	{0, 0, 0, F_INV_OP | FF_RESPOND, NULL, NULL, /* MAINT OUT */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
-	{0, 0x2f, 0, F_D_OUT_MAYBE | FF_MEDIA_IO, NULL, NULL, /* VERIFY(10) */
-	    {10,  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xc7,
-	     0, 0, 0, 0, 0, 0} },
+	{ARRAY_SIZE(verify_iarr), 0x8f, 0,
+	    F_D_OUT_MAYBE | FF_MEDIA_IO, resp_verify,	/* VERIFY(16) */
+	    verify_iarr, {16,  0xf6, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x3f, 0xc7} },
 	{ARRAY_SIZE(vl_iarr), 0x7f, 0x9, F_SA_HIGH | F_D_IN | FF_MEDIA_IO,
 	    resp_read_dt0, vl_iarr,	/* VARIABLE LENGTH, READ(32) */
 	    {32,  0xc7, 0, 0, 0, 0, 0x3f, 0x18, 0x0, 0x9, 0xfe, 0, 0xff, 0xff,
@@ -2579,7 +2588,7 @@ static int do_dout_fetch(struct scsi_cmnd *scp, u32 num, u8 *doutp)
  * arr into sip->storep+lba and return true. If comparison fails then
  * return false. */
 static bool comp_write_worker(struct sdeb_store_info *sip, u64 lba, u32 num,
-			      const u8 *arr)
+			      const u8 *arr, bool compare_only)
 {
 	bool res;
 	u64 block, rest = 0;
@@ -2599,6 +2608,8 @@ static bool comp_write_worker(struct sdeb_store_info *sip, u64 lba, u32 num,
 			     rest * lb_size);
 	if (!res)
 		return res;
+	if (compare_only)
+		return true;
 	arr += num * lb_size;
 	memcpy(fsp + (block * lb_size), arr, (num - rest) * lb_size);
 	if (rest)
@@ -3524,7 +3535,7 @@ static int resp_comp_write(struct scsi_cmnd *scp,
 		sdev_printk(KERN_INFO, scp->device, "%s: compare_write: cdb "
 			    "indicated=%u, IO sent=%d bytes\n", my_name,
 			    dnum * lb_size, ret);
-	if (!comp_write_worker(sip, lba, num, arr)) {
+	if (!comp_write_worker(sip, lba, num, arr, false)) {
 		mk_sense_buffer(scp, MISCOMPARE, MISCOMPARE_VERIFY_ASC, 0);
 		retval = check_condition_result;
 		goto cleanup;
@@ -3771,6 +3782,82 @@ static int resp_report_luns(struct scsi_cmnd *scp,
 	return res;
 }
 
+static int resp_verify(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
+{
+	bool is_bytchk3 = false;
+	u8 bytchk;
+	int ret, j;
+	u32 vnum, a_num, off;
+	const u32 lb_size = sdebug_sector_size;
+	unsigned long iflags;
+	u64 lba;
+	u8 *arr;
+	u8 *cmd = scp->cmnd;
+	struct sdeb_store_info *sip = devip2sip(devip);
+	rwlock_t *macc_lckp = sip ? &sip->macc_lck : &sdeb_fake_rw_lck;
+
+	bytchk = (cmd[1] >> 1) & 0x3;
+	if (bytchk == 0) {
+		return 0;	/* always claim internal verify okay */
+	} else if (bytchk == 2) {
+		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, 2);
+		return check_condition_result;
+	} else if (bytchk == 3) {
+		is_bytchk3 = true;	/* 1 block sent, compared repeatedly */
+	}
+	switch (cmd[0]) {
+	case VERIFY_16:
+		lba = get_unaligned_be64(cmd + 2);
+		vnum = get_unaligned_be32(cmd + 10);
+		break;
+	case VERIFY:		/* is VERIFY(10) */
+		lba = get_unaligned_be32(cmd + 2);
+		vnum = get_unaligned_be16(cmd + 7);
+		break;
+	default:
+		mk_sense_invalid_opcode(scp);
+		return check_condition_result;
+	}
+	a_num = is_bytchk3 ? 1 : vnum;
+	/* Treat following check like one for read (i.e. no write) access */
+	ret = check_device_access_params(scp, lba, a_num, false);
+	if (ret)
+		return ret;
+
+	arr = kcalloc(lb_size, vnum, GFP_ATOMIC);
+	if (!arr) {
+		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
+				INSUFF_RES_ASCQ);
+		return check_condition_result;
+	}
+	/* Not changing store, so only need read access */
+	read_lock_irqsave(macc_lckp, iflags);
+
+	ret = do_dout_fetch(scp, a_num, arr);
+	if (ret == -1) {
+		ret = DID_ERROR << 16;
+		goto cleanup;
+	} else if (sdebug_verbose && (ret < (a_num * lb_size))) {
+		sdev_printk(KERN_INFO, scp->device,
+			    "%s: %s: cdb indicated=%u, IO sent=%d bytes\n",
+			    my_name, __func__, a_num * lb_size, ret);
+	}
+	if (is_bytchk3) {
+		for (j = 1, off = lb_size; j < vnum; ++j, off += lb_size)
+			memcpy(arr + off, arr, lb_size);
+	}
+	ret = 0;
+	if (!comp_write_worker(sip, lba, vnum, arr, true)) {
+		mk_sense_buffer(scp, MISCOMPARE, MISCOMPARE_VERIFY_ASC, 0);
+		ret = check_condition_result;
+		goto cleanup;
+	}
+cleanup:
+	read_unlock_irqrestore(macc_lckp, iflags);
+	kfree(arr);
+	return ret;
+}
+
 static struct sdebug_queue *get_queue(struct scsi_cmnd *cmnd)
 {
 	u32 tag = blk_mq_unique_tag(cmnd->request);
-- 
2.26.1

