Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96A41E9C
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfFLIFw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 04:05:52 -0400
Received: from mail-eopbgr810083.outbound.protection.outlook.com ([40.107.81.83]:35392
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfFLIFw (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Jun 2019 04:05:52 -0400
Received: from SN4PR0701CA0003.namprd07.prod.outlook.com
 (2603:10b6:803:28::13) by BN7PR07MB4433.namprd07.prod.outlook.com
 (2603:10b6:406:b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Wed, 12 Jun
 2019 08:05:49 +0000
Received: from BY2NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::209) by SN4PR0701CA0003.outlook.office365.com
 (2603:10b6:803:28::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.15 via Frontend
 Transport; Wed, 12 Jun 2019 08:05:49 +0000
Authentication-Results: spf=fail (sender IP is 199.233.58.38)
 smtp.mailfrom=marvell.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=marvell.com;
Received-SPF: Fail (protection.outlook.com: domain of marvell.com does not
 designate 199.233.58.38 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.233.58.38; helo=CAEXCH02.caveonetworks.com;
Received: from CAEXCH02.caveonetworks.com (199.233.58.38) by
 BY2NAM05FT006.mail.protection.outlook.com (10.152.100.143) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1987.5 via Frontend Transport; Wed, 12 Jun 2019 08:05:49 +0000
Received: from dut1171.mv.qlogic.com (10.112.88.18) by
 CAEXCH02.caveonetworks.com (10.67.98.110) with Microsoft SMTP Server (TLS) id
 14.2.347.0; Wed, 12 Jun 2019 01:06:04 -0700
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])    by
 dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5C85kJW017311;    Wed, 12
 Jun 2019 01:05:46 -0700
Received: (from root@localhost) by dut1171.mv.qlogic.com
 (8.14.7/8.14.7/Submit) id x5C85kor017310;      Wed, 12 Jun 2019 01:05:46 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>, <lduncan@suse.com>,
        <cleech@redhat.com>
CC:     <linux-scsi@vger.kernel.org>, <QLogic-Storage-Upstream@cavium.com>
Subject: [PATCH 1/2] qedi: Check targetname while finding boot target information
Date:   Wed, 12 Jun 2019 01:05:41 -0700
Message-ID: <20190612080542.17272-2-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190612080542.17272-1-njavali@marvell.com>
References: <20190612080542.17272-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132048003495094287;(abac79dc-c90b-41ba-8033-08d666125e47);(abac79dc-c90b-41ba-8033-08d666125e47)
X-Forefront-Antispam-Report: CIP:199.233.58.38;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(376002)(396003)(136003)(2980300002)(1110001)(339900001)(189003)(199004)(51234002)(2201001)(8936002)(126002)(50466002)(305945005)(1076003)(47776003)(50226002)(11346002)(486006)(336012)(36906005)(26826003)(107886003)(2616005)(105606002)(81166006)(4326008)(8676002)(6666004)(356004)(498600001)(70206006)(81156014)(446003)(68736007)(42186006)(16586007)(110136005)(48376002)(54906003)(86362001)(476003)(26005)(316002)(51416003)(36756003)(76130400001)(87636003)(5660300002)(2906002)(76176011)(53936002)(69596002)(70586007)(80596001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4433;H:CAEXCH02.caveonetworks.com;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05bc76e8-0bfe-43b6-99b4-08d6ef0cc816
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN7PR07MB4433;
X-MS-TrafficTypeDiagnostic: BN7PR07MB4433:
X-Microsoft-Antispam-PRVS: <BN7PR07MB4433B9F85183B6AA71489279AFEC0@BN7PR07MB4433.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0066D63CE6
X-Microsoft-Antispam-Message-Info: AQMRbgiU4zQgn1hEpkLuAtZ7VywC/VABilFsjOGIDjD0xkfvs6MoTzmw6SSk1L9C21HAD7kJRjk+d9KbGOAS3hUL8koCGnNOWMAv01DS8pfqWedW9g2Cukg+eO/WQdZIAbFNV+LhO8yKkq7KVuLzuHynGzl+1NTr5v4awx9eNOqNjlSVYvDkAA/DyG3z27XsRRoy8ggufNV/DHava+4LCu0lG4MLro00kYBRZS/pkF4ayzMYMpmrNSOu1t3DMwVvI8zQHHwU8xQ3eqSSnCyRNx9KVbJU74OcJdrloS04ZwLYVz9LAEhjboAnQLhl04MvTC1QYqEckd6SX+Ysfc8CPK+PIhhIE1ds3X5Sum770btPA3/0DLfz9mPobdgx9ve5AqmNHTdGC/OivVUk1yv8y3GZHw52Hzp1zPR33K+soIo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2019 08:05:49.2552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bc76e8-0bfe-43b6-99b4-08d6ef0cc816
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[199.233.58.38];Helo=[CAEXCH02.caveonetworks.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4433
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The kernel panic was observed during iSCSI discovery via offload
with below call trace,

[ 2115.646901] BUG: unable to handle kernel NULL pointer dereference at (null)
[ 2115.646909] IP: [<ffffffffacf7f0cc>] strncmp+0xc/0x60
[ 2115.646927] PGD 0
[ 2115.646932] Oops: 0000 [#1] SMP
[ 2115.647107] CPU: 24 PID: 264 Comm: kworker/24:1 Kdump: loaded Tainted: G
               OE  ------------   3.10.0-957.el7.x86_64 #1
[ 2115.647133] Workqueue: slowpath-13:00. qed_slowpath_task [qed]
[ 2115.647135] task: ffff8d66af80b0c0 ti: ffff8d66afb80000 task.ti: ffff8d66afb80000
[ 2115.647136] RIP: 0010:[<ffffffffacf7f0cc>]  [<ffffffffacf7f0cc>] strncmp+0xc/0x60
[ 2115.647141] RSP: 0018:ffff8d66afb83c68  EFLAGS: 00010206
[ 2115.647143] RAX: 0000000000000001 RBX: 0000000000000007 RCX: 000000000000000a
[ 2115.647144] RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffff8d632b3ba040
[ 2115.647145] RBP: ffff8d66afb83c68 R08: 0000000000000000 R09: 000000000000ffff
[ 2115.647147] R10: 0000000000000007 R11: 0000000000000800 R12: ffff8d66a30007a0
[ 2115.647148] R13: ffff8d66747a3c10 R14: ffff8d632b3ba000 R15: ffff8d66747a32f8
[ 2115.647149] FS:  0000000000000000(0000) GS:ffff8d66aff00000(0000) knlGS:0000000000000000
[ 2115.647151] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2115.647152] CR2: 0000000000000000 CR3: 0000000509610000 CR4: 00000000007607e0
[ 2115.647153] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2115.647154] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2115.647155] PKRU: 00000000
[ 2115.647157] Call Trace:
[ 2115.647165]  [<ffffffffc0634cc5>] qedi_get_protocol_tlv_data+0x2c5/0x510 [qedi]
[ 2115.647184]  [<ffffffffc05968f5>] ? qed_mfw_process_tlv_req+0x245/0xbe0 [qed]
[ 2115.647195]  [<ffffffffc05496cb>] qed_mfw_fill_tlv_data+0x4b/0xb0 [qed]
[ 2115.647206]  [<ffffffffc0596911>] qed_mfw_process_tlv_req+0x261/0xbe0 [qed]
[ 2115.647215]  [<ffffffffacce0e8e>] ? dequeue_task_fair+0x41e/0x660
[ 2115.647221]  [<ffffffffacc2a59e>] ? __switch_to+0xce/0x580
[ 2115.647230]  [<ffffffffc0546013>] qed_slowpath_task+0xa3/0x160 [qed]
[ 2115.647278] RIP  [<ffffffffacf7f0cc>] strncmp+0xc/0x60

Fix kernel panic by validating the session targetname before providing
TLV data and confirming the presence of boot targets.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qedi/qedi_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 8814bfc..f210a3e 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -987,6 +987,9 @@ static int qedi_find_boot_info(struct qedi_ctx *qedi,
 		if (!iscsi_is_session_online(cls_sess))
 			continue;
 
+		if (!sess->targetname)
+			continue;
+
 		if (pri_ctrl_flags) {
 			if (!strcmp(pri_tgt->iscsi_name, sess->targetname) &&
 			    !strcmp(pri_tgt->ip_addr, ep_ip_addr)) {
-- 
1.8.3.1

