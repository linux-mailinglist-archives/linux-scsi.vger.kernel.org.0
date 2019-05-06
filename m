Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59715518
	for <lists+linux-scsi@lfdr.de>; Mon,  6 May 2019 22:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEFUxc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 May 2019 16:53:32 -0400
Received: from mail-eopbgr820072.outbound.protection.outlook.com ([40.107.82.72]:40736
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfEFUxb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 May 2019 16:53:31 -0400
Received: from SN4PR0701CA0006.namprd07.prod.outlook.com
 (2603:10b6:803:28::16) by DM6PR07MB6107.namprd07.prod.outlook.com
 (2603:10b6:5:18a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.12; Mon, 6 May
 2019 20:53:29 +0000
Received: from DM3NAM05FT047.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by SN4PR0701CA0006.outlook.office365.com
 (2603:10b6:803:28::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.11 via Frontend
 Transport; Mon, 6 May 2019 20:53:29 +0000
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
 15.20.1856.4 via Frontend Transport; Mon, 6 May 2019 20:53:29 +0000
Received: from dut1171.mv.qlogic.com (10.112.88.18) by
 CAEXCH02.caveonetworks.com (10.67.98.110) with Microsoft SMTP Server (TLS) id
 14.2.347.0; Mon, 6 May 2019 13:52:21 -0700
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])    by
 dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x46KqK38007877;    Mon, 6
 May 2019 13:52:20 -0700
Received: (from root@localhost) by dut1171.mv.qlogic.com
 (8.14.7/8.14.7/Submit) id x46KqJ5Z007876;      Mon, 6 May 2019 13:52:19 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 0/2] qla2xxx: Bug fixes for the driver 
Date:   Mon, 6 May 2019 13:52:17 -0700
Message-ID: <20190506205219.7842-1-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132016496093788273;(abac79dc-c90b-41ba-8033-08d666125e47);(abac79dc-c90b-41ba-8033-08d666125e47)
X-Forefront-Antispam-Report: CIP:199.233.58.38;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(376002)(396003)(2980300002)(1110001)(339900001)(189003)(199004)(498600001)(87636003)(53936002)(5660300002)(68736007)(80596001)(36756003)(69596002)(26826003)(85426001)(356004)(1076003)(14444005)(4326008)(50226002)(81156014)(2616005)(126002)(70206006)(70586007)(76130400001)(486006)(336012)(26005)(476003)(54906003)(42186006)(2906002)(51416003)(305945005)(36906005)(110136005)(316002)(16586007)(4743002)(4744005)(8676002)(47776003)(81166006)(8936002)(48376002)(105606002)(86362001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6107;H:CAEXCH02.caveonetworks.com;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 016c72d6-6dea-4467-2a46-08d6d264e4a0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600141)(711020)(4605104)(2017052603328);SRVR:DM6PR07MB6107;
X-MS-TrafficTypeDiagnostic: DM6PR07MB6107:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6107BDCBE035A5409EDFA840D6300@DM6PR07MB6107.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0029F17A3F
X-Microsoft-Antispam-Message-Info: RHuyag/czmvmCFEdNTeh/gLV7OqNMwv+5X8JzYqE2glruv8FtoBJ85ynRXmoK36RQmoU42rHzKZgqHASJcsEJZOIpPkNJorqtUQT286/VQOqcvBARsjk7OhRtnXRHaAKcYCzFgwiDqasquZAe0Yyu3fkRzeuOjxA57Na5zCsQTxmiRWjOmVZ0z8lmN67FM4q9oa9SamewXNyX8/DMaMCT5FBbL97AVqhxfyWFo7Vd+KWz2LlvxoQoc2en9itGviLggY0x3v78CuiQlyPQGsKkEPmGqo2x2gPCEgEKbrEvG5XPSQuig1YBe9GUMgY41mQV/KWGKeF0ZL62bQmn7cMQzlnQLOYr/Z9ICqv43urSNRXQDlj4ffys3UoBAMh8+D9dmbffLuLlmxpu+nBwxxg6jANEWYnQK2Zyiy55i9Tjfc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2019 20:53:29.0265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016c72d6-6dea-4467-2a46-08d6d264e4a0
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[199.233.58.38];Helo=[CAEXCH02.caveonetworks.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6107
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

This series fixes issue with driver's EEH handling and NULL pointer access
while accessing optrom.

Please apply these patches to 5.2/scsi-queue at your earliest convenience.

Thanks,
Himanshu

Quinn Tran (2):
  qla2xxx: Fix Crash due to NULL pointer access in
    qla2x00_sysfs_read_optrom()
  qla2xxx: Add cleanup for PCI EEH recovery

 drivers/scsi/qla2xxx/qla_attr.c |   3 +-
 drivers/scsi/qla2xxx/qla_os.c   | 221 +++++++++++++++-------------------------
 2 files changed, 84 insertions(+), 140 deletions(-)

-- 
2.12.0

