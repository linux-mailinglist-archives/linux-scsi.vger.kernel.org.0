Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E12E463912
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Nov 2021 16:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbhK3PHI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Nov 2021 10:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbhK3O4z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Nov 2021 09:56:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4777DC061D7C;
        Tue, 30 Nov 2021 06:51:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 89FD0CE1A4C;
        Tue, 30 Nov 2021 14:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A37C53FD0;
        Tue, 30 Nov 2021 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638283857;
        bh=SUurU2bwaLmW/ODrNAtqZRvL1+/BsSrKCM8L1cmVcnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNlKsrv5lgHJYJzcnSLT5OjR4h1dPp+fk9xfiuj7VwEIXtzhsDAvSFj6on6spj9am
         B7Q//doBpnYebQiIuHjZF6XpeVGbXxxpmbzApn24EQjk1BgyKqBWREFQMKGJs1FH04
         frJC63Z65x2eaMeMA/oxmcQ+hlhiTwxlCVX0sy49+AmYr8oH1dKsg38UB4l9KtkwQh
         oVopkY4q+fP+iGM0sB2l3CPp0UeSpcuc74A1ROTcjWoDfa0wfO8dcoX0cSqrFH7hBQ
         /j3ZAh8DtdCEVTb8jhLUrMh5cmxhiKXVm0mdPGDw4gLY3uk3E8gM1KnrzII5jiZPGk
         d1sb4iNzUDxKw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     George Kennedy <george.kennedy@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/43] scsi: scsi_debug: Fix type in min_t to avoid stack OOB
Date:   Tue, 30 Nov 2021 09:49:50 -0500
Message-Id: <20211130145022.945517-13-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: George Kennedy <george.kennedy@oracle.com>

[ Upstream commit 36e07d7ede88a1f1ef8f0f209af5b7612324ac2c ]

Change min_t() to use type "u32" instead of type "int" to avoid stack out
of bounds. With min_t() type "int" the values get sign extended and the
larger value gets used causing stack out of bounds.

BUG: KASAN: stack-out-of-bounds in memcpy include/linux/fortify-string.h:191 [inline]
BUG: KASAN: stack-out-of-bounds in sg_copy_buffer+0x1de/0x240 lib/scatterlist.c:976
Read of size 127 at addr ffff888072607128 by task syz-executor.7/18707

CPU: 1 PID: 18707 Comm: syz-executor.7 Not tainted 5.15.0-syzk #1
Hardware name: Red Hat KVM, BIOS 1.13.0-2
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x89/0xb5 lib/dump_stack.c:106
 print_address_description.constprop.9+0x28/0x160 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold.14+0x7d/0x117 mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x1a3/0x210 mm/kasan/generic.c:189
 memcpy+0x23/0x60 mm/kasan/shadow.c:65
 memcpy include/linux/fortify-string.h:191 [inline]
 sg_copy_buffer+0x1de/0x240 lib/scatterlist.c:976
 sg_copy_from_buffer+0x33/0x40 lib/scatterlist.c:1000
 fill_from_dev_buffer.part.34+0x82/0x130 drivers/scsi/scsi_debug.c:1162
 fill_from_dev_buffer drivers/scsi/scsi_debug.c:1888 [inline]
 resp_readcap16+0x365/0x3b0 drivers/scsi/scsi_debug.c:1887
 schedule_resp+0x4d8/0x1a70 drivers/scsi/scsi_debug.c:5478
 scsi_debug_queuecommand+0x8c9/0x1ec0 drivers/scsi/scsi_debug.c:7533
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1520 [inline]
 scsi_queue_rq+0x16b0/0x2d40 drivers/scsi/scsi_lib.c:1699
 blk_mq_dispatch_rq_list+0xb9b/0x2700 block/blk-mq.c:1639
 __blk_mq_sched_dispatch_requests+0x28f/0x590 block/blk-mq-sched.c:325
 blk_mq_sched_dispatch_requests+0x105/0x190 block/blk-mq-sched.c:358
 __blk_mq_run_hw_queue+0xe5/0x150 block/blk-mq.c:1761
 __blk_mq_delay_run_hw_queue+0x4f8/0x5c0 block/blk-mq.c:1838
 blk_mq_run_hw_queue+0x18d/0x350 block/blk-mq.c:1891
 blk_mq_sched_insert_request+0x3db/0x4e0 block/blk-mq-sched.c:474
 blk_execute_rq_nowait+0x16b/0x1c0 block/blk-exec.c:62
 sg_common_write.isra.18+0xeb3/0x2000 drivers/scsi/sg.c:836
 sg_new_write.isra.19+0x570/0x8c0 drivers/scsi/sg.c:774
 sg_ioctl_common+0x14d6/0x2710 drivers/scsi/sg.c:939
 sg_ioctl+0xa2/0x180 drivers/scsi/sg.c:1165
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x19d/0x220 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3a/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Link: https://lore.kernel.org/r/1636484247-21254-1-git-send-email-george.kennedy@oracle.com
Reported-by: syzkaller <syzkaller@googlegroups.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_debug.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 3fc7c2a31c191..f2f202424c6b2 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1188,7 +1188,7 @@ static int p_fill_from_dev_buffer(struct scsi_cmnd *scp, const void *arr,
 		 __func__, off_dst, scsi_bufflen(scp), act_len,
 		 scsi_get_resid(scp));
 	n = scsi_bufflen(scp) - (off_dst + act_len);
-	scsi_set_resid(scp, min_t(int, scsi_get_resid(scp), n));
+	scsi_set_resid(scp, min_t(u32, scsi_get_resid(scp), n));
 	return 0;
 }
 
@@ -1561,7 +1561,8 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	unsigned char pq_pdt;
 	unsigned char *arr;
 	unsigned char *cmd = scp->cmnd;
-	int alloc_len, n, ret;
+	u32 alloc_len, n;
+	int ret;
 	bool have_wlun, is_disk, is_zbc, is_disk_zbc;
 
 	alloc_len = get_unaligned_be16(cmd + 3);
@@ -1584,7 +1585,8 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		kfree(arr);
 		return check_condition_result;
 	} else if (0x1 & cmd[1]) {  /* EVPD bit set */
-		int lu_id_num, port_group_id, target_dev_id, len;
+		int lu_id_num, port_group_id, target_dev_id;
+		u32 len;
 		char lu_id_str[6];
 		int host_no = devip->sdbg_host->shost->host_no;
 		
@@ -1675,9 +1677,9 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 			kfree(arr);
 			return check_condition_result;
 		}
-		len = min(get_unaligned_be16(arr + 2) + 4, alloc_len);
+		len = min_t(u32, get_unaligned_be16(arr + 2) + 4, alloc_len);
 		ret = fill_from_dev_buffer(scp, arr,
-			    min(len, SDEBUG_MAX_INQ_ARR_SZ));
+			    min_t(u32, len, SDEBUG_MAX_INQ_ARR_SZ));
 		kfree(arr);
 		return ret;
 	}
@@ -1713,7 +1715,7 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	}
 	put_unaligned_be16(0x2100, arr + n);	/* SPL-4 no version claimed */
 	ret = fill_from_dev_buffer(scp, arr,
-			    min_t(int, alloc_len, SDEBUG_LONG_INQ_SZ));
+			    min_t(u32, alloc_len, SDEBUG_LONG_INQ_SZ));
 	kfree(arr);
 	return ret;
 }
@@ -1728,8 +1730,8 @@ static int resp_requests(struct scsi_cmnd *scp,
 	unsigned char *cmd = scp->cmnd;
 	unsigned char arr[SCSI_SENSE_BUFFERSIZE];	/* assume >= 18 bytes */
 	bool dsense = !!(cmd[1] & 1);
-	int alloc_len = cmd[4];
-	int len = 18;
+	u32 alloc_len = cmd[4];
+	u32 len = 18;
 	int stopped_state = atomic_read(&devip->stopped);
 
 	memset(arr, 0, sizeof(arr));
@@ -1773,7 +1775,7 @@ static int resp_requests(struct scsi_cmnd *scp,
 			arr[7] = 0xa;
 		}
 	}
-	return fill_from_dev_buffer(scp, arr, min_t(int, len, alloc_len));
+	return fill_from_dev_buffer(scp, arr, min_t(u32, len, alloc_len));
 }
 
 static int resp_start_stop(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
@@ -2311,7 +2313,8 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 {
 	int pcontrol, pcode, subpcode, bd_len;
 	unsigned char dev_spec;
-	int alloc_len, offset, len, target_dev_id;
+	u32 alloc_len, offset, len;
+	int target_dev_id;
 	int target = scp->device->id;
 	unsigned char *ap;
 	unsigned char arr[SDEBUG_MAX_MSENSE_SZ];
@@ -2467,7 +2470,7 @@ static int resp_mode_sense(struct scsi_cmnd *scp,
 		arr[0] = offset - 1;
 	else
 		put_unaligned_be16((offset - 2), arr + 0);
-	return fill_from_dev_buffer(scp, arr, min_t(int, alloc_len, offset));
+	return fill_from_dev_buffer(scp, arr, min_t(u32, alloc_len, offset));
 }
 
 #define SDEBUG_MAX_MSELECT_SZ 512
@@ -2582,7 +2585,8 @@ static int resp_ie_l_pg(unsigned char *arr)
 static int resp_log_sense(struct scsi_cmnd *scp,
 			  struct sdebug_dev_info *devip)
 {
-	int ppc, sp, pcode, subpcode, alloc_len, len, n;
+	int ppc, sp, pcode, subpcode;
+	u32 alloc_len, len, n;
 	unsigned char arr[SDEBUG_MAX_LSENSE_SZ];
 	unsigned char *cmd = scp->cmnd;
 
@@ -2652,9 +2656,9 @@ static int resp_log_sense(struct scsi_cmnd *scp,
 		mk_sense_invalid_fld(scp, SDEB_IN_CDB, 3, -1);
 		return check_condition_result;
 	}
-	len = min_t(int, get_unaligned_be16(arr + 2) + 4, alloc_len);
+	len = min_t(u32, get_unaligned_be16(arr + 2) + 4, alloc_len);
 	return fill_from_dev_buffer(scp, arr,
-		    min_t(int, len, SDEBUG_MAX_INQ_ARR_SZ));
+		    min_t(u32, len, SDEBUG_MAX_INQ_ARR_SZ));
 }
 
 static inline bool sdebug_dev_is_zoned(struct sdebug_dev_info *devip)
@@ -4405,7 +4409,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	put_unaligned_be64(sdebug_capacity - 1, arr + 8);
 
 	rep_len = (unsigned long)desc - (unsigned long)arr;
-	ret = fill_from_dev_buffer(scp, arr, min_t(int, alloc_len, rep_len));
+	ret = fill_from_dev_buffer(scp, arr, min_t(u32, alloc_len, rep_len));
 
 fini:
 	read_unlock(macc_lckp);
-- 
2.33.0

