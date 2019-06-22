Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56504F433
	for <lists+linux-scsi@lfdr.de>; Sat, 22 Jun 2019 09:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfFVHof (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 22 Jun 2019 03:44:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37506 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFVHoe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 22 Jun 2019 03:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561189474; x=1592725474;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cmS31mdza1Z/smfA7S59mHGUg1yEA16QQUZWFzvJGJE=;
  b=MFd06C41ZqToi65DjxfvdCs46QMy80nYKPs1ZiZA82AHLVbPQI3hu8h3
   FVoLz9JGj71czf1STcBGoRwhLZ+MKfrhWdrvSa2lq4C1AuP5dTAd+rRkC
   Xkg0fxxTE19e0Hqpk88WFQs7PvWizom8b78/OH+Veg0iMFypPxsZCKu4Z
   7FAYq7b/tQ5JVu97aIYzhkXBDLqkSei0dCC3NCz6NhpIfZeVW4vcBmllZ
   NuDolTBRE2gRZq48k3ApqMMD8C3Uh56/c5DzaSMwfepnX/FYpUC9djmBF
   EAa+Sju0ZDS7X3z182NVPvaIu8raB9EHeG0rBiKk2QTxFOp6xNlyabvZI
   w==;
X-IronPort-AV: E=Sophos;i="5.63,403,1557158400"; 
   d="scan'208";a="116100503"
Received: from mail-dm3nam05lp2057.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.57])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2019 15:44:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVfAzeWKPjwzEBUMvoo0SViW6MraF4lRVtNynHpgDjs=;
 b=qGCT07mZ6m/F/evLCmc/gpvEPTWF4hauemPuO+i5wqgoJazYWNthxqeGu+PUEpkyYh6ChuOnsycPImRoaxOz8TDAhc0EJUVq6xenUD1MkMaLCYIuUid8aThj3O9xL+6Eg1PGjfPwc642+IBTsESD+9m5ZM6TXjL4aTokfP1YNec=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5729.namprd04.prod.outlook.com (20.179.74.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Sat, 22 Jun 2019 07:44:31 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8a2:c0fb:fa15:3f16]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8a2:c0fb:fa15:3f16%4]) with mapi id 15.20.2008.014; Sat, 22 Jun 2019
 07:44:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] sd_zbc: Fix report zones buffer allocation
Thread-Topic: [PATCH] sd_zbc: Fix report zones buffer allocation
Thread-Index: AQHVJxsEGH+YXZvugk2bYyKptWPqEg==
Date:   Sat, 22 Jun 2019 07:44:31 +0000
Message-ID: <BN8PR04MB58120578F3032EC46017CBF6E7E60@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20190620034812.3254-1-damien.lemoal@wdc.com>
 <b6f250ad-0473-4643-8611-e395295e0379@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6302f07-bc98-4803-b1f2-08d6f6e576a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR04MB5729;
x-ms-traffictypediagnostic: BN8PR04MB5729:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN8PR04MB5729D24B0ACCC64228669840E7E60@BN8PR04MB5729.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(25786009)(76116006)(256004)(33656002)(186003)(26005)(229853002)(55016002)(8676002)(81166006)(14444005)(66556008)(102836004)(66066001)(76176011)(7696005)(305945005)(99286004)(91956017)(73956011)(66946007)(14454004)(2501003)(64756008)(478600001)(6436002)(6246003)(2906002)(52536014)(71190400001)(446003)(486006)(68736007)(66476007)(66446008)(81156014)(110136005)(72206003)(6506007)(3846002)(71200400001)(5660300002)(7736002)(53936002)(316002)(74316002)(4326008)(476003)(9686003)(8936002)(6116002)(53546011)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5729;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A949H6mVTMd87dQ6/jQke57iGy9XHs8mwr2JLvlcnQ3p3Mfhdz4HJxDzSvesXgp91hO9s253M4R6tKJ9xaU3CdrR6QCBRqryGtLQFdtymkMcU1dyAIp+oePLp/m9PKrfmsw2NdtqTTGBZwONhi4+Qfh06hEQVVyTBknA+HIKxTQ7Iqo/VEDjPyA0AkmFMc9NVXCrmYzd1IyGRfktXgf95KqzrCci7Kwtx796cgs9mPq3Z/FABld0AunQ4v2ca/LTGDGFao7BNWAcGEutrvb1Yls9Ou5ok6fiSR9/PZJATOdV7OQ7J6rmDC7qmDThk03914TEbZ4k15R8XEk3OY/u8/WnEtqZLgAlQF0rzbC81sOnXBSSzYK4zYFVIMbD1BdE+tW0kxZxXdpSya9rS7cMtxFpXPR/ABqDmn1cZ8qt8EQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6302f07-bc98-4803-b1f2-08d6f6e576a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 07:44:31.5976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5729
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019/06/21 0:25, Bart Van Assche wrote:=0A=
> On 6/19/19 8:48 PM, Damien Le Moal wrote:=0A=
>> +	/*=0A=
>> +	 * Limit the command buffer size to the arbitrary SD_ZBC_REPORT_SIZE=
=0A=
>> +	 * size (1MB), allowing up to 16383 zone descriptors being reported wi=
th=0A=
>> +	 * a single command. And make sure that this size does not exceed the=
=0A=
>> +	 * hardware capabilities. To avoid disk revalidation failures due to=
=0A=
>> +	 * memory allocation errors, retry the allocation with a smaller buffe=
r=0A=
>> +	 * size if the allocation fails.=0A=
>> +	 */=0A=
>> +	bufsize =3D min_t(size_t, *buflen, SD_ZBC_REPORT_SIZE);=0A=
>> +	bufsize =3D min_t(size_t, bufsize,=0A=
>> +			queue_max_hw_sectors(disk->queue) << 9);=0A=
>> +	for (order =3D get_order(bufsize); order >=3D 0; order--) {=0A=
>> +		page =3D alloc_pages(gfp_mask, order);=0A=
>> +		if (page) {=0A=
>> +			*buflen =3D PAGE_SIZE << order;=0A=
>> +			return page_address(page);=0A=
>> +		}=0A=
>> +	}=0A=
> =0A=
> Hi Damien,=0A=
> =0A=
> As you know Linux memory fragmentation tends to increase over time. The =
=0A=
> above code has the very unfortunate property that the more memory is =0A=
> fragmented the smaller the allocated buffer will become. I don't think =
=0A=
> that's how kernel code should work. Have you considered to use vmalloc() =
=0A=
> + blk_rq_map_sg() instead? See also efa_vmalloc_buf_to_sg() for an =0A=
> example of how to build a scatterlist for memory allocated by vmalloc().=
=0A=
=0A=
Bart,=0A=
=0A=
I have a fix along the lines you suggested, but since it modifies=0A=
bio_rq_map_kern(), I would rather not push that as a bug fix this late in R=
C.=0A=
Would you agree to accept the fix patch as is for now and I will send the m=
ore=0A=
complete fix for 5.3 ? Note that this more complete fix also reworks the si=
milar=0A=
memory allocation for the struct blk_zone array used for zone revalidation.=
 Put=0A=
all together, the use of report zones uses only vmalloc-ed buffers and data=
=0A=
structures, reduces pressure on the memory system and reducing chances of f=
ailures.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
