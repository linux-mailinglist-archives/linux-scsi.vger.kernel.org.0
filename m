Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F395476E94
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfGZQIL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:08:11 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:3156 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfGZQIL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:08:11 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG6tZJ025887;
        Fri, 26 Jul 2019 09:08:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=csYTGT7Kcurj8O00crnfc+2iBHenhvjKAaeVz+WAMcU=;
 b=LQp0GkNKEa9kGacfMayr73KxZNjqPmlOYj2aqyDQI8lNl5/3hRnr2GlHo/BNsKW6pylp
 JveR+lJk+E89xaxm3pUpZxjhlB+uur14Glnt8TbTopI9H3QoMSMLypuYxGLkdIwcfRej
 hGv7ISLgY9YKBJRmKPW4Gf63uam2RT/jMAQVpp8I9uVA9jEsGcV0Gtm2LfZWmgjB3N+f
 jHqSc/lRKrYorc+JnoYIX46XubLPgiCvmyKsl4IN1itpnD42ow3QdYdSpO9DOyTu1Ii6
 XJ5QGZaDnRAjNfVvOfG/D902JZIXSUow9mGD5Qg6jnZc/C21Imu0OvZzpJdYwv6a6Bb3 8Q== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tx6256xbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:07 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:06 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:08:06 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 411733F703F;
        Fri, 26 Jul 2019 09:08:06 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG86jk025762;
        Fri, 26 Jul 2019 09:08:06 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG86fw025761;
        Fri, 26 Jul 2019 09:08:06 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 08/15] qla2xxx: Fix premature timer expiration
Date:   Fri, 26 Jul 2019 09:07:33 -0700
Message-ID: <20190726160740.25687-9-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_11:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

For any qla2xxx async command, the SRB buffer is used to send
it. In setting up the SRB buffer, the timer for this command
is started before all memory allocation has finished.  Under
low memory pressure, memory alloc can go to sleep and not wake
up before the timer expires. Once timer has expired, the timer
thread will access uninitialize fields resulting into NULL
pointer crash.

This patch fixes this crash by moving the start of timer after
everything is setup.

backtrace shows following

PID: 3720   TASK: ffff996928401040  CPU: 0   COMMAND: "qla2xxx_1_dpc"
0 [ffff99652751b698] __schedule at ffffffff965676c7
1 [ffff99652751b728] schedule at ffffffff96567bc9
2 [ffff99652751b738] schedule_timeout at ffffffff965655e8
3 [ffff99652751b7e0] io_schedule_timeout at ffffffff9656726d
4 [ffff99652751b810] congestion_wait at ffffffff95fd8d12
5 [ffff99652751b870] isolate_migratepages_range at ffffffff95fddaf3
6 [ffff99652751b930] compact_zone at ffffffff95fdde96
7 [ffff99652751b980] compact_zone_order at ffffffff95fde0bc
8 [ffff99652751ba20] try_to_compact_pages at ffffffff95fde481
9 [ffff99652751ba80] __alloc_pages_direct_compact at ffffffff9655cc31
10 [ffff99652751bae0] __alloc_pages_slowpath at ffffffff9655d101
11 [ffff99652751bbd0] __alloc_pages_nodemask at ffffffff95fc0e95
12 [ffff99652751bc80] dma_generic_alloc_coherent at ffffffff95e3217f
13 [ffff99652751bcc8] x86_swiotlb_alloc_coherent at ffffffff95e6b7a1
14 [ffff99652751bcf8] qla2x00_rft_id at ffffffffc055b5e0 [qla2xxx]
15 [ffff99652751bd50] qla2x00_loop_resync at ffffffffc0533e71 [qla2xxx]
16 [ffff99652751be68] qla2x00_do_dpc at ffffffffc05210ca [qla2xxx]

PID: 0      TASK: ffffffff96a18480  CPU: 0   COMMAND: "swapper/0"
 0 [ffff99652fc03ae0] machine_kexec at ffffffff95e63674
 1 [ffff99652fc03b40] __crash_kexec at ffffffff95f1ce12
 2 [ffff99652fc03c10] crash_kexec at ffffffff95f1cf00
 3 [ffff99652fc03c28] oops_end at ffffffff9656c758
 4 [ffff99652fc03c50] no_context at ffffffff9655aa7e
 5 [ffff99652fc03ca0] __bad_area_nosemaphore at ffffffff9655ab15
 6 [ffff99652fc03cf0] bad_area_nosemaphore at ffffffff9655ac86
 7 [ffff99652fc03d00] __do_page_fault at ffffffff9656f6b0
 8 [ffff99652fc03d70] do_page_fault at ffffffff9656f915
 9 [ffff99652fc03da0] page_fault at ffffffff9656b758
    [exception RIP: unknown or invalid address]
    RIP: 0000000000000000  RSP: ffff99652fc03e50  RFLAGS: 00010202
    RAX: 0000000000000000  RBX: ffff99652b79a600  RCX: ffff99652b79a760
    RDX: ffff99652b79a600  RSI: ffffffffc0525ad0  RDI: ffff99652b79a600
    RBP: ffff99652fc03e60   R8: ffffffff96a18a18   R9: ffffffff96ee3c00
    R10: 0000000000000002  R11: ffff99652fc03de8  R12: ffff99652b79a760
    R13: 0000000000000100  R14: ffffffffc0525ad0  R15: ffff99652b79a600
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
10 [ffff99652fc03e50] qla2x00_sp_timeout at ffffffffc0525af8 [qla2xxx]
11 [ffff99652fc03e68] call_timer_fn at ffffffff95ea7f58
12 [ffff99652fc03ea0] run_timer_softirq at ffffffff95eaa3bd
13 [ffff99652fc03f18] __do_softirq at ffffffff95ea0f05
14 [ffff99652fc03f88] call_softirq at ffffffff9657832c
15 [ffff99652fc03fa0] do_softirq at ffffffff95e2e675
16 [ffff99652fc03fc0] irq_exit at ffffffff95ea1285
17 [ffff99652fc03fd8] smp_apic_timer_interrupt at ffffffff965796c8
18 [ffff99652fc03ff0] apic_timer_interrupt at ffffffff96575df2

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h  | 1 +
 drivers/scsi/qla2xxx/qla_iocb.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index d3d624d43ec3..b91ef7b75e8d 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -537,6 +537,7 @@ typedef struct srb {
 	wait_queue_head_t nvme_ls_waitq;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
+	unsigned int start_timer:1;
 	uint32_t handle;
 	uint16_t flags;
 	uint16_t type;
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 9312b19ed708..1886de92034c 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2540,7 +2540,7 @@ void qla2x00_init_timer(srb_t *sp, unsigned long tmo)
 	sp->free = qla2x00_sp_free;
 	if (IS_QLAFX00(sp->vha->hw) && sp->type == SRB_FXIOCB_DCMD)
 		init_completion(&sp->u.iocb_cmd.u.fxiocb.fxiocb_comp);
-	add_timer(&sp->u.iocb_cmd.timer);
+	sp->start_timer = 1;
 }
 
 static void
@@ -3668,6 +3668,9 @@ qla2x00_start_sp(srb_t *sp)
 		break;
 	}
 
+	if (sp->start_timer)
+		add_timer(&sp->u.iocb_cmd.timer);
+
 	wmb();
 	qla2x00_start_iocbs(vha, qp->req);
 done:
-- 
2.12.0

