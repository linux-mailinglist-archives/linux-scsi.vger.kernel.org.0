Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C8274B7
	for <lists+linux-scsi@lfdr.de>; Thu, 23 May 2019 05:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfEWDQZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 May 2019 23:16:25 -0400
Received: from mail-eopbgr1310125.outbound.protection.outlook.com ([40.107.131.125]:64512
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728668AbfEWDQY (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 May 2019 23:16:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=iiR3i806Gh4gB9N/pN8GyypHUHC5URc0hcLXr/y5dog8jfyuGQ/r6rxhD3Ek8ladvqBGe+7RXPkIThhlUf1VIoLAfBBO2VCTfZ2GoFMHahk0y4ULUY9qhEnB8EOLp1KIWYyDJ9AkYIsKWz9yGSQybY/nc5olmqxEONWfYOw1XtY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSWRuxlgAMCCgUzW1/7IrGYH7R6n6OqG+xDSH9inxXk=;
 b=CmiYCTs1AidB5QBzFzS55mpcnpvCqMmsWWsZPhi8Q11z3j5JeJOpnvSuLUDHH/8Hz1039mqTuTR4ZBqY9VeKk8B0tALhMo+0ipWuaqGLbXKd2L+Y9nrPpgJRdcLLnyM9iW1mzFVKwwL6wJIsbm4UmrsJAHpEg7RosncOMOHulH8=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSWRuxlgAMCCgUzW1/7IrGYH7R6n6OqG+xDSH9inxXk=;
 b=WVG6VH56u/9HYTCHS0v3sOP5Z2wTFsEvNImzEyPMCqHTO75akvxqCT2yLJXNv6QWznyxSFTTRcB25HVdk4wGTQOWEtlyUDLOQbbmo5lO4Hy95+NKOkVeOxXZVRm5+LXvyHj2iJUS29XwcJydg/zyMkD83JTdKQAMseZ28OjqLXU=
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM (10.170.173.13) by
 KU1P153MB0152.APCP153.PROD.OUTLOOK.COM (10.170.173.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.3; Thu, 23 May 2019 03:16:17 +0000
Received: from KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::8de:bacb:9100:3e25]) by KU1P153MB0166.APCP153.PROD.OUTLOOK.COM
 ([fe80::8de:bacb:9100:3e25%6]) with mapi id 15.20.1943.007; Thu, 23 May 2019
 03:16:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        vkuznets <vkuznets@redhat.com>, Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: SCSI adapter: how to freeze and thaw I/O on hibernation?
Thread-Topic: SCSI adapter: how to freeze and thaw I/O on hibernation?
Thread-Index: AdURELHvLfnzwMBzRu65bCFYUUVo1A==
Date:   Thu, 23 May 2019 03:16:17 +0000
Message-ID: <KU1P153MB016617EB56A9B6ED55B8CFD0BF010@KU1P153MB0166.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-23T03:16:14.4905998Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fbfed8d4-7b79-4d81-af3d-959c58cd9fac;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:fcae:4c89:7bbd:a740]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1432d4f8-1b1b-46be-a5b7-08d6df2d0578
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:KU1P153MB0152;
x-ms-traffictypediagnostic: KU1P153MB0152:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <KU1P153MB0152BD1FE7376CC468C16750BF010@KU1P153MB0152.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(189003)(86362001)(2501003)(33656002)(14454004)(86612001)(10290500003)(25786009)(486006)(478600001)(476003)(14444005)(9686003)(55016002)(6436002)(256004)(66476007)(66556008)(64756008)(66446008)(66946007)(22452003)(73956011)(76116006)(8990500004)(71190400001)(68736007)(71200400001)(7696005)(316002)(53936002)(305945005)(7736002)(6116002)(46003)(102836004)(5660300002)(10090500001)(74316002)(2906002)(81156014)(6506007)(186003)(8936002)(54906003)(110136005)(81166006)(8676002)(99286004)(107886003)(52536014)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:KU1P153MB0152;H:KU1P153MB0166.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IpcwfCkfq++6jpYjb1Ne3TUhljcQWyATYBoLhjHIdxygfbwiYB5tsdmDR1tze2D0a9XQ2H5oyoQeQ/YO4d+6Hq9gypQ0dXyvZm7hXFvqTsKHj29QUeSSVwXamgDgMFk51zkGWQN1khhddg/WO98AqrwFa0U+cEmifK0MthMNivnkGVBryjwOK44zrIH1mfTFA5lr0xHQCpEMqNykaJnbAtLE2E+HeG0A6g3GuXwFoD2tc2o/F8Hkc0kZuMIcGwJEwl6DXMIFVfJuoa9jebmjtBGYZ0RqFl2qb8GqK9tDmL9fNVNvYXfllCf0ySFvQ3PgXUMy6TsC4dm4Fu/bSfAkqjQs2dVB9cyWZH1M4I8o30jj5fc74JtJK28yEbQCUgLvfFTjBKpsVXNsom0S2n1zQWshXz6LxvWOYM9Nk/8vbNk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1432d4f8-1b1b-46be-a5b7-08d6df2d0578
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 03:16:17.3671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0152
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,
I'm adding code to enable the hv_storvsc driver (drivers/scsi/storvsc_drv.c=
)
for hibernation (ACPI S5). I know how to save/restore the state of the virt=
ual
Hyper-V SCSI adapter, but I don't know how to prevent the higher layer SCSI
driver(s) from submitting new I/O requests to the low level driver hv_storv=
sc,
before I disable the Hyper-V SCSI adapter in hv_storvsc.

Note: I can not call scsi_remove_host(), because the SCSI host should not
disappear and re-appear on hibernation.

scsi_target_block() calls scsi_internal_device_block() ->
blk_mq_quiesce_queue(), but it is only used in a few drivers
(scsi_transport_fc.c, scsi_transport_iscsi.c and scsi_transport_srp.c), so
I doubt it is suitable to me?

scsi_block_requests() is used in a lot of drivers and hence is more likely
to be the API I'm looking for, but it only sets a flag
shost->host_self_blocked -- how can this prevent another CPU from
submitting I/O requests?

I also checked scsi_bus_pm_ops, but it's only for "sdev": see
scsi_bus_suspend_common() -> "if (scsi_is_sdev_device(dev))...".

Even for "sdev", it looks the scsi_dev_type_suspend() can't work for me,
because it looks the sdev's driver is sd, whose sd_pm_ops doesn't
define the .freeze and .thaw ops, which are needed in hibernation.

sd_pm_ops does define .suspend and .resume, but it looks they are only
for suspend-to-memory (ACPI S3).

Can you please recommend the standard way to prevent the higher layer
SCSI driver(s) from submitting new I/O requests?

How do the other low level SCSI adapter drivers support hibernation?

I checked some PCI HBA drivers, and they use scsi_block_requests(), but
as I described above, I don't know how setting a flag can prevent another
CPU from submitting I/O requests.

Looking forward to your insights!

Thanks!
--Dexuan
