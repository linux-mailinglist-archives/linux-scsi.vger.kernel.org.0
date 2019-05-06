Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9643D15517
	for <lists+linux-scsi@lfdr.de>; Mon,  6 May 2019 22:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfEFUxb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 16:53:31 -0400
Received: from mail-eopbgr680079.outbound.protection.outlook.com ([40.107.68.79]:7233
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfEFUxb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 May 2019 16:53:31 -0400
Received: from SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) by MN2PR07MB6109.namprd07.prod.outlook.com
 (2603:10b6:208:107::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.10; Mon, 6 May
 2019 20:53:28 +0000
Received: from DM3NAM05FT047.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by SN4PR0701CA0004.outlook.office365.com
 (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Mon, 6 May 2019 20:53:28 +0000
Authentication-Results: spf=fail (sender IP is 199.233.58.38)
 smtp.mailfrom=marvell.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=marvell.com;
Received-SPF: Fail (protection.outlook.com: domain of marvell.com does not
 designate 199.233.58.38 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.233.58.38; helo=CAEXCH02.caveonetworks.com;
Received: from CAEXCH02.caveonetworks.com (199.233.58.38) by
 DM3NAM05FT047.mail.protection.outlook.com (10.152.98.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1856.4 via Frontend Transport; Mon, 6 May 2019 20:53:27 +0000
Received: from dut1171.mv.qlogic.com (10.112.88.18) by
 CAEXCH02.caveonetworks.com (10.67.98.110) with Microsoft SMTP Server (TLS) id
 14.2.347.0; Mon, 6 May 2019 13:52:24 -0700
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])    by
 dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x46KqNU7007881;    Mon, 6
 May 2019 13:52:23 -0700
Received: (from root@localhost) by dut1171.mv.qlogic.com
 (8.14.7/8.14.7/Submit) id x46KqNoQ007880;      Mon, 6 May 2019 13:52:23 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 1/2] qla2xxx: Fix Crash due to NULL pointer access in qla2x00_sysfs_read_optrom()
Date:   Mon, 6 May 2019 13:52:18 -0700
Message-ID: <20190506205219.7842-2-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190506205219.7842-1-hmadhani@marvell.com>
References: <20190506205219.7842-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132016496080809385;(abac79dc-c90b-41ba-8033-08d666125e47);(abac79dc-c90b-41ba-8033-08d666125e47)
X-Forefront-Antispam-Report: CIP:199.233.58.38;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(136003)(346002)(2980300002)(1110001)(339900001)(189003)(199004)(48376002)(85426001)(105606002)(50466002)(47776003)(36756003)(2906002)(53936002)(4326008)(81156014)(80596001)(69596002)(16586007)(76130400001)(42186006)(316002)(36906005)(70586007)(70206006)(14444005)(68736007)(50226002)(81166006)(8936002)(8676002)(6666004)(356004)(486006)(1076003)(26005)(5660300002)(54906003)(110136005)(51416003)(336012)(2616005)(446003)(11346002)(76176011)(126002)(476003)(45080400002)(87636003)(498600001)(26826003)(305945005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB6109;H:CAEXCH02.caveonetworks.com;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98a2b3bc-0942-4ff6-a3d7-08d6d264e3d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600141)(711020)(4605104)(2017052603328);SRVR:MN2PR07MB6109;
X-MS-TrafficTypeDiagnostic: MN2PR07MB6109:
X-Microsoft-Antispam-PRVS: <MN2PR07MB61091DDDE4519C076C388F0DD6300@MN2PR07MB6109.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-Forefront-PRVS: 0029F17A3F
X-Microsoft-Antispam-Message-Info: tNXXbr3BEkn4x3euzZNgl6Z+D/SIOeWl7hVXWiNFwy/wYuA55NU/ciaVUo1IACHkE2LX7A6jV686e9ErfawWt8cA7qlBAE4DnQvZmRhgYcch2nJC7so8E12f09mnee5w9AnlaT8CI7TpY4tEIkRzixWqV3FpbW0HPnoGnW8VTF7Fmhj3TeQrJpk64ejITSZQWR6QVIn33ghHy7t92Vo2TPBcE2GAR1C0/f9kYUu6MGdxYzunPYznKX6k29UgmvbKr/llTcA2fWKASq1fnMepBuWs67xscCB+qJT2YXXmand953a+mFDMnQLvLtX3qLkN8SfwoLOm3zRfsZ0dYHyuW5B0e64aNd7Fz4rYiW+z0uGZo0rZVNr+wy0Yi1ryZpSJXbMoFeMBcknR1MkJ+orBKD0FTae65m6LfE6V7SDfEx4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2019 20:53:27.6197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a2b3bc-0942-4ff6-a3d7-08d6d264e3d2
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[199.233.58.38];Helo=[CAEXCH02.caveonetworks.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6109
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

commit c7702b8c2271 ("scsi: qla2xxx: Get mutex lock before checking
optrom_state") fixed crash while reading optrom data by adding mutex
locking. However, there can be still case where previous WRITE for
optrom buffer failed and then read_optrom() is called with NULL
optrom_buffer. This patch fixes access to read optrom data if the
buffers are NULL.

following stack trace is seen in the log file

[3130734.630350] BUG: unable to handle kernel NULL pointer dereference at           (null)
[3130734.630366] IP: [<ffffffff81287526>] memcpy+0x6/0x110
[3130734.630373] PGD 0
[3130734.630374] Oops: 0000 [#1] SMP
[3130734.630375] Modules linked in: iscsi_target_mod target_core_mod configfs ip_vs tcp_diag dccp_diag dccp inet_diag fuse nfsv3 nfs_acl nfsv4 auth_rpcgs>
[3130734.630401]  hwmon dm_mirror dm_region_hash dm_log dm_mod ipv6 autofs4 [last unloaded: emcpioc]
[3130734.630404] CPU 9
[3130734.630407] Pid: 14513, comm: udevadm Tainted: PF          O 3.8.13-118.10.2.el7uek.x86_64 #2 Oracle Corporation SUN SERVER X4-2       /ASSY,MB,X4-2>
[3130734.630409] RIP: 0010:[<ffffffff81287526>]  [<ffffffff81287526>] memcpy+0x6/0x110
[3130734.630411] RSP: 0018:ffff88036c7a3e48  EFLAGS: 00010206
[3130734.630411] RAX: ffff880106b0f000 RBX: 0000000000001000 RCX: 0000000000001000
[3130734.630412] RDX: 0000000000001000 RSI: 0000000000000000 RDI: ffff880106b0f000
[3130734.630413] RBP: ffff88036c7a3e68 R08: 0000000000001000 R09: 0000000000000007
[3130734.630414] R10: 0000000000000004 R11: 0000000000000005 R12: ffff88036c7a3e78
[3130734.630414] R13: 0000000000001000 R14: ffff881fc96945e0 R15: ffff881fc7e99ba8
[3130734.630415] FS:  00007f5e245948c0(0000) GS:ffff881fff320000(0000) knlGS:0000000000000000
[3130734.630416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[3130734.630417] CR2: 0000000000000000 CR3: 0000000106a88000 CR4: 00000000001407e0
[3130734.630418] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[3130734.630418] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[3130734.630419] Process udevadm (pid: 14513, threadinfo ffff88036c7a2000, task ffff880ee5820500)
[3130734.630420] Stack:
[3130734.630421]  ffffffff811ad38c ffff881fc9694000 ffff880106b0f000 0000000000001000
[3130734.630424]  ffff88036c7a3ea0 ffffffffa02dea5c 0000000000000000 ffff881014fd9540
[3130734.630427]  ffff881010863dc0 ffff88036c7a3f50 0000000000001000 ffff88036c7a3f08
[3130734.630429] Call Trace:
[3130734.630435]  [<ffffffff811ad38c>] ? memory_read_from_buffer+0x3c/0x60
[3130734.630445]  [<ffffffffa02dea5c>] qla2x00_sysfs_read_optrom+0x9c/0xc0 [qla2xxx]
[3130734.630449]  [<ffffffff811fe96f>] read+0xdf/0x1f0
[3130734.630454]  [<ffffffff81187ff3>] vfs_read+0xa3/0x180
[3130734.630455]  [<ffffffff81188299>] sys_read+0x49/0xa0
[3130734.630461]  [<ffffffff810df3b6>] ? __audit_syscall_exit+0x1f6/0x2a0
[3130734.630467]  [<ffffffff815874f9>] system_call_fastpath+0x16/0x1b
[3130734.630467] Code: 43 58 48 2b 43 50 88 43 4e 5b 5d c3 66 0f 1f 84 00 00 00 00 00 e8 fb fb ff ff eb e2 90 90 90 90 90 90 90 90 90 48 89 f8 48 89 d1 <>
[3130734.630485] RIP  [<ffffffff81287526>] memcpy+0x6/0x110
[3130734.630486]  RSP <ffff88036c7a3e48>
[3130734.630487] CR2: 0000000000000000

Fixes: c7702b8c2271 ("scsi: qla2xxx: Get mutex lock before checking optrom_state")
Cc: stable@vger.kernel.org # 4.10
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_attr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 8d560c562e9c..0341f3340edb 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -275,7 +275,8 @@ qla2x00_sysfs_read_optrom(struct file *filp, struct kobject *kobj,
 
 	mutex_lock(&ha->optrom_mutex);
 
-	if (ha->optrom_state != QLA_SREADING)
+	if ((ha->optrom_state != QLA_SREADING) ||
+	    !buf || !ha->optrom_buffer)
 		goto out;
 
 	rval = memory_read_from_buffer(buf, count, &off, ha->optrom_buffer,
-- 
2.12.0

