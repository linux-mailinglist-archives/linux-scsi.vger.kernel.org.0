Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C882E793
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 23:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2VpF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 17:45:05 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57330 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbfE2VpF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 17:45:05 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TLhVEu007015;
        Wed, 29 May 2019 14:44:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=WwAqbSiEUfSH80gMjGNL1ThfUuBtnoEHnEWq/vOYV98=;
 b=r5evGeui/aVRzjZuYL2dOTxuZ3GDRVTGKa17JvzQwyT+HyBgGNNcsZSe4dzVgvTusopN
 QPLmR3kpNfXbr+INLzZ3M1iViI8WpIUBAC8PAUllipqd29QmrHm43pmmewZW1JXrXlcZ
 dsCXEVI3nKtwAJ4BBsVdT9rAFwnSNxIDnJKpXh2jPlFpYvF3kuBY9Di4Bmw1WwVKApcj
 KbuOWtVi0aacTGodsXG3Jz3SfZvZ4FtH9k3wS66+w6uHEs/kHP2LUYAqLlXNeBIMqsmX
 +b42X+bgDFzV2dIAUgRnpNBzPY9moQ5LqPbr5NKh3UDDfsRhwn9JYfM4VguKjMlK56SA pg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sskp8bq3d-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 14:44:44 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 14:44:31 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 14:44:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwAqbSiEUfSH80gMjGNL1ThfUuBtnoEHnEWq/vOYV98=;
 b=QlsMbsyPXAgyWAcaUzGtV8DLF7iiHyJ+gOmGFHxVG0bYWal5Wku1WPeIfmIOB2+6RsnrgXLE9R8jiG7wCLTI2rzjLbE4QZjubQP4lKi6KmTufwUsmJc4nIzul9SBw/H+gylV0JB8HVjG1P5cBLysMSow+YDwiJAq9lvdztCfoqM=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB2415.namprd18.prod.outlook.com (20.179.81.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Wed, 29 May 2019 21:44:29 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 21:44:29 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 00/20] qla2xxx Patches
Thread-Topic: [PATCH 00/20] qla2xxx Patches
Thread-Index: AQHVFl0hfbkVfDox10q7eP6nDI8xQaaCoqaA
Date:   Wed, 29 May 2019 21:44:29 +0000
Message-ID: <794547A0-2D81-42DD-8777-27B9BE607E21@marvell.com>
References: <20190529202826.204499-1-bvanassche@acm.org>
In-Reply-To: <20190529202826.204499-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19cc5eba-b381-4bbc-542e-08d6e47ed3f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2415;
x-ms-traffictypediagnostic: MN2PR18MB2415:
x-microsoft-antispam-prvs: <MN2PR18MB2415D49BCE5FC33D21655525D61F0@MN2PR18MB2415.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(396003)(346002)(51914003)(199004)(189003)(25786009)(26005)(36756003)(6506007)(33656002)(6916009)(8936002)(68736007)(316002)(5660300002)(478600001)(76176011)(6512007)(66066001)(71190400001)(83716004)(2616005)(71200400001)(53546011)(53936002)(476003)(11346002)(256004)(54906003)(446003)(82746002)(4326008)(14444005)(186003)(3846002)(6116002)(99286004)(50226002)(6246003)(14454004)(6486002)(86362001)(6436002)(486006)(8676002)(2906002)(66446008)(66476007)(81156014)(66946007)(76116006)(102836004)(81166006)(91956017)(64756008)(66556008)(7736002)(229853002)(305945005)(73956011)(57306001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2415;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0D1gNnDZceYnz78vuMC8nSKj75/j0L5phLQdeNg3Osckc9LeeKK/xV/s/jFWVaFu40MxvQtkNVoCXmqnPd/KypEpsqU80LUl7g+yXVD/zMsBICihhB81b9JbLJpQbuLglZgGV7SkVWCrJbiqpS8Od6uUAoznst1LnxuyStxPHSDK9pWtplvA8rZpHoxLiXHgcg5U3yaYqUVu/gmWhIw795XmS3ALIYTgDwwfmjFc8Q11fh0HL96P38k4JizqPeGQeQZcTpjG1yG+Lpa0d2QL8RHf2oosB+Nt1c0K0DaaVTlYFP3MrTNGUNSHBxK9VutTRQ1PIMrDNAeYQfmnB16A3RwIQt8vvdx5qKUZ7AVAYiEqVA3xdDMfxABkiz1O/+W0CjQddyFW/nhDECgO6DycTC3923ZBKwWCSrvuT+QFsb4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85045651A31A08419BC980648304985D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cc5eba-b381-4bbc-542e-08d6e47ed3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 21:44:29.1409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmadhani@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2415
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_11:,,
 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,=20

Thanks for the series. We will provide ACK after these patches have gone th=
rough our internal testing.

Thanks,
Himanshu

> On May 29, 2019, at 1:28 PM, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> Hi Martin,
>=20
> This patch series is the result of code review, inspection of the Coverit=
y
> output and actual testing. The first two patches in this series are inten=
ded
> for the current release cycle (kernel v5.2) and the other 18 patches are
> intended for the kernel v5.3 merge window. Please consider these patches.
>=20
> Thanks,
>=20
> Bart.
>=20
> Bart Van Assche (20):
>  qla2xxx: Include the <asm/unaligned.h> header file from qla_dsd.h
>  qla2xxx: Really fix abort handling
>  qla2xxx: Remove an include directive from qla_mr.c
>  qla2xxx: Remove a forward declaration
>  qla2xxx: Declare the fourth ql_dump_buffer() argument const
>  qla2xxx: Change the return type of qla2x00_update_ms_fdmi_iocb() into
>    void
>  qla2xxx: Reduce the scope of three local variables in
>    qla2xxx_queuecommand()
>  qla2xxx: Declare qla_tgt_cmd.cdb const
>  qla2xxx: Change data_dsd into an array
>  qla2xxx: Verify locking assumptions at runtime
>  qla2xxx: Reduce the number of casts in GID list code
>  qla2xxx: Improve Linux kernel coding style conformance
>  qla2xxx: Remove two superfluous if-tests
>  qla2xxx: Simplify qlt_lport_dump()
>  qla2xxx: Introduce qla2x00_els_dcmd2_free()
>  qla2xxx: Remove a superfluous pointer check
>  qla2xxx: Remove two superfluous tests
>  qla2xxx: Fix session lookup in qlt_abort_work()
>  qla2xxx: Introduce the be_id_t and le_id_t data types for FC src/dst
>    IDs
>  qla2xxx: Fix qla24xx_abort_sp_done()
>=20
> drivers/scsi/qla2xxx/qla_dbg.c     |   3 +-
> drivers/scsi/qla2xxx/qla_def.h     |  75 ++++++++++--
> drivers/scsi/qla2xxx/qla_dfs.c     |   9 +-
> drivers/scsi/qla2xxx/qla_dsd.h     |   2 +
> drivers/scsi/qla2xxx/qla_gbl.h     |   4 +-
> drivers/scsi/qla2xxx/qla_gs.c      |  41 +++----
> drivers/scsi/qla2xxx/qla_init.c    |  42 +++----
> drivers/scsi/qla2xxx/qla_iocb.c    |  44 ++++----
> drivers/scsi/qla2xxx/qla_mr.c      |   1 -
> drivers/scsi/qla2xxx/qla_nvme.c    |   4 +-
> drivers/scsi/qla2xxx/qla_nvme.h    |   2 +-
> drivers/scsi/qla2xxx/qla_nx.c      |  10 +-
> drivers/scsi/qla2xxx/qla_nx.h      |  14 +--
> drivers/scsi/qla2xxx/qla_os.c      |  40 ++++---
> drivers/scsi/qla2xxx/qla_target.c  | 176 +++++++++++------------------
> drivers/scsi/qla2xxx/qla_target.h  |  35 ++----
> drivers/scsi/qla2xxx/tcm_qla2xxx.c |  23 +---
> 17 files changed, 250 insertions(+), 275 deletions(-)
>=20
> --=20
> 2.22.0.rc1
>=20

