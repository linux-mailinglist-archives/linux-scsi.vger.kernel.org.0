Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1FB41E9D
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 10:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436750AbfFLIFz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 04:05:55 -0400
Received: from mail-eopbgr800070.outbound.protection.outlook.com ([40.107.80.70]:35192
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfFLIFy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Jun 2019 04:05:54 -0400
Received: from SN4PR0701CA0019.namprd07.prod.outlook.com
 (2603:10b6:803:28::29) by BN6PR07MB2868.namprd07.prod.outlook.com
 (2603:10b6:404:41::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Wed, 12 Jun
 2019 08:05:52 +0000
Received: from BY2NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by SN4PR0701CA0019.outlook.office365.com
 (2603:10b6:803:28::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.17 via Frontend
 Transport; Wed, 12 Jun 2019 08:05:52 +0000
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
 15.20.1987.5 via Frontend Transport; Wed, 12 Jun 2019 08:05:52 +0000
Received: from dut1171.mv.qlogic.com (10.112.88.18) by
 CAEXCH02.caveonetworks.com (10.67.98.110) with Microsoft SMTP Server (TLS) id
 14.2.347.0; Wed, 12 Jun 2019 01:06:07 -0700
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])    by
 dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5C85niA017315;    Wed, 12
 Jun 2019 01:05:49 -0700
Received: (from root@localhost) by dut1171.mv.qlogic.com
 (8.14.7/8.14.7/Submit) id x5C85nXL017314;      Wed, 12 Jun 2019 01:05:49 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>, <lduncan@suse.com>,
        <cleech@redhat.com>
CC:     <linux-scsi@vger.kernel.org>, <QLogic-Storage-Upstream@cavium.com>
Subject: [PATCH 2/2] qedi: update driver version to 8.37.0.20
Date:   Wed, 12 Jun 2019 01:05:42 -0700
Message-ID: <20190612080542.17272-3-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190612080542.17272-1-njavali@marvell.com>
References: <20190612080542.17272-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132048003525849054;(abac79dc-c90b-41ba-8033-08d666125e47);(abac79dc-c90b-41ba-8033-08d666125e47)
X-Forefront-Antispam-Report: CIP:199.233.58.38;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39850400004)(2980300002)(1110001)(339900001)(199004)(189003)(16586007)(70206006)(305945005)(51416003)(126002)(47776003)(26826003)(42186006)(15650500001)(316002)(76176011)(87636003)(36756003)(68736007)(86362001)(80596001)(498600001)(36906005)(48376002)(69596002)(50466002)(2201001)(110136005)(8676002)(486006)(81166006)(81156014)(54906003)(336012)(446003)(8936002)(11346002)(50226002)(2616005)(1076003)(4744005)(476003)(26005)(105606002)(76130400001)(4326008)(356004)(6666004)(107886003)(5660300002)(2906002)(70586007)(53936002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2868;H:CAEXCH02.caveonetworks.com;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 257eee57-3a0b-4286-e1a8-08d6ef0cc9eb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN6PR07MB2868;
X-MS-TrafficTypeDiagnostic: BN6PR07MB2868:
X-Microsoft-Antispam-PRVS: <BN6PR07MB2868166889AD9547CC186153AFEC0@BN6PR07MB2868.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 0066D63CE6
X-Microsoft-Antispam-Message-Info: KTFNlavNaRx5hdK1z0tcubttBaesy8UgCJ9KoEg5zw0jGTy/0S8pDQ0iGRVd613C16FQFNC0yiKs8V7susrlEJdjyB2OANtZD/J1j2FTjdHpBtIN6pJnGaMELkWR6JgjvwDC+j0o7fhQIpqo2Lgt9eT+w1Z7zFryN3oZKia+QAw0Ghpm7SXFAc/m8Q3AH2HTgoDzFWlpFbNX13UsfZOA3IRF8WyC+X0OBMRnhqjHCWCL6BDK6qBiw9jBEuHVte4lZFW1kEj3jc0fIr7OoK2+19IVlnY5O2JARsYp1VrH0Bc2egEhe6L7zeE9Pt33wdRi09Mdp4nctrR71e1Q4kdEHfogAokwaUzsgJ/3hdRsbih2lZg/URzHDHYC5X10yjXoa/I/RH2q83XwobEKzUHez//sIIOzqbfeHgKnTp7qym0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2019 08:05:52.3407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257eee57-3a0b-4286-e1a8-08d6ef0cc9eb
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[199.233.58.38];Helo=[CAEXCH02.caveonetworks.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2868
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update qedi driver version to 8.37.0.20

Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qedi/qedi_version.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_version.h b/drivers/scsi/qedi/qedi_version.h
index f56f0ba..0ac1055 100644
--- a/drivers/scsi/qedi/qedi_version.h
+++ b/drivers/scsi/qedi/qedi_version.h
@@ -4,8 +4,8 @@
  * Copyright (c) 2016 Cavium Inc.
  */
 
-#define QEDI_MODULE_VERSION	"8.33.0.21"
+#define QEDI_MODULE_VERSION	"8.37.0.20"
 #define QEDI_DRIVER_MAJOR_VER		8
-#define QEDI_DRIVER_MINOR_VER		33
+#define QEDI_DRIVER_MINOR_VER		37
 #define QEDI_DRIVER_REV_VER		0
-#define QEDI_DRIVER_ENG_VER		21
+#define QEDI_DRIVER_ENG_VER		20
-- 
1.8.3.1

