Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7141E9B
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 10:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfFLIFt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 04:05:49 -0400
Received: from mail-eopbgr730071.outbound.protection.outlook.com ([40.107.73.71]:38775
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfFLIFs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Jun 2019 04:05:48 -0400
Received: from SN4PR0701CA0003.namprd07.prod.outlook.com
 (2603:10b6:803:28::13) by BN6PR07MB2866.namprd07.prod.outlook.com
 (2603:10b6:404:42::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Wed, 12 Jun
 2019 08:05:46 +0000
Received: from BY2NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::209) by SN4PR0701CA0003.outlook.office365.com
 (2603:10b6:803:28::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.15 via Frontend
 Transport; Wed, 12 Jun 2019 08:05:46 +0000
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
 15.20.1987.5 via Frontend Transport; Wed, 12 Jun 2019 08:05:45 +0000
Received: from dut1171.mv.qlogic.com (10.112.88.18) by
 CAEXCH02.caveonetworks.com (10.67.98.110) with Microsoft SMTP Server (TLS) id
 14.2.347.0; Wed, 12 Jun 2019 01:06:01 -0700
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])    by
 dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x5C85hnF017307;    Wed, 12
 Jun 2019 01:05:43 -0700
Received: (from root@localhost) by dut1171.mv.qlogic.com
 (8.14.7/8.14.7/Submit) id x5C85gVQ017306;      Wed, 12 Jun 2019 01:05:42 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>, <lduncan@suse.com>,
        <cleech@redhat.com>
CC:     <linux-scsi@vger.kernel.org>, <QLogic-Storage-Upstream@cavium.com>
Subject: [PATCH 0/2] qedi bug fix and update driver version
Date:   Wed, 12 Jun 2019 01:05:40 -0700
Message-ID: <20190612080542.17272-1-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132048003459519939;(abac79dc-c90b-41ba-8033-08d666125e47);(abac79dc-c90b-41ba-8033-08d666125e47)
X-Forefront-Antispam-Report: CIP:199.233.58.38;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(376002)(396003)(136003)(346002)(2980300002)(1110001)(339900001)(189003)(199004)(2906002)(81156014)(5660300002)(16586007)(36756003)(47776003)(69596002)(14444005)(4326008)(15650500001)(80596001)(1076003)(42186006)(356004)(76130400001)(53936002)(110136005)(86362001)(2201001)(26005)(54906003)(316002)(81166006)(8676002)(107886003)(36906005)(26826003)(8936002)(105606002)(498600001)(486006)(70586007)(87636003)(50466002)(70206006)(4744005)(126002)(476003)(2616005)(336012)(51416003)(305945005)(68736007)(50226002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2866;H:CAEXCH02.caveonetworks.com;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e64543-4cad-491f-570b-08d6ef0cc5ea
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:BN6PR07MB2866;
X-MS-TrafficTypeDiagnostic: BN6PR07MB2866:
X-Microsoft-Antispam-PRVS: <BN6PR07MB286638412A96FD263BC75046AFEC0@BN6PR07MB2866.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0066D63CE6
X-Microsoft-Antispam-Message-Info: tcL4D9OZwM6CaSg8ia+8IYB4v/0RzYka7YC7o5R8XGgU1pltSKb1lxJ1nR+jsiCxH238GlEgqdVjMrBrrVaZ9JWJqdzBtEC6w4cSSYnoNr8igmXNMQiL0XPTEiai0zzo+1Qu7tlCjtRoIvEYwxh6+3UAeo++yp2wnXbq8hFIPLOWmjVfdkPd/2tHCzsBCvbExF2zo4jOIs9maMa3nbunR8Wcc8u91XHP0/2nxJ1p6h85K5lCpIeNOoxle439yKi4BSlaVowNYqdiTfTxmO1TYnDczsfsSum1qe53hB34WxUWPJFoIDmZ6vyKpNoxD6v8f/7GhTYaLwixRS0jV7aFqtXYvJGNCCJsMbcdoiwp615P/+0LFWMwFFeGJ6IYnn014tC6R9oj77c8tSW18dz3jlfR/0v3j8G2teGDxq1ioMA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2019 08:05:45.5486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e64543-4cad-491f-570b-08d6ef0cc5ea
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[199.233.58.38];Helo=[CAEXCH02.caveonetworks.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2866
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Martin,

Please apply the following patches to the scsi tree at your
earliest convenience.

Nilesh Javali (2):
  qedi: Check targetname while finding boot target information
  qedi: update driver version to 8.37.0.20

 drivers/scsi/qedi/qedi_main.c    | 3 +++
 drivers/scsi/qedi/qedi_version.h | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.8.3.1

