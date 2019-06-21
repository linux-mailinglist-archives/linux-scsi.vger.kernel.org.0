Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCCB4DE45
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 02:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfFUA6i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 20:58:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45048 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUA6i (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 20:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561078716; x=1592614716;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iOoy+YY08jP7q6pL/g2PVs7hdi5mcJZ+bASE0kppTR0=;
  b=OFiqsdemjKoI2jUHkKH4O8Kzt8lCuBB3qmw28eY79cdGA9TqZxCMxDvI
   BVVRSV6RipxnAoSYYIk6tG4H9cF3bcm9Rmq5DWrP4b5h+xljSZZhVRquN
   oeRX/PkmvxErhM9fDupajHqsZTkiJTDfgelwd9BiveESPmvhMmNbSKI2+
   o+g8kDygJv4Wifc/6f7LLq85TgIvm0tXwT3KQySitslaFyst2DH38OZ7M
   qbbobqI8i+k+s76xDREDqQB405zRVDZDou8xDLYG7iMTYSbsb4FGD+Tes
   NRSEmEDuA4oFYAxDo1nGeWGYzB0Udp6XSUZyLmUEEjeC9LiSK/kmsfYn3
   w==;
X-IronPort-AV: E=Sophos;i="5.63,398,1557158400"; 
   d="scan'208";a="112342628"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2019 08:58:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pygm7EboOrOEO//2cmkqU5t7OAb1/z8uzkdGw5PGRZA=;
 b=LE7WbJYtyyIWESajA/UQqYpXlOYn+h4E/vURGrB45s1WTEQtXo2VGBIWJi2RIkEFDjqPCtiRK9StlMJ8LwO8niq12sJzU60ZyYNnGh2XZP434cKjZzYvBdQ5zAP9hpeGn1m4CnZiUnri8BA42QUylsaRmNTa6qpIcrk4xgBbGrM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5320.namprd04.prod.outlook.com (20.178.49.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Fri, 21 Jun 2019 00:58:35 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 00:58:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] sd_zbc: Fix report zones buffer allocation
Thread-Topic: [PATCH] sd_zbc: Fix report zones buffer allocation
Thread-Index: AQHVJxsEGH+YXZvugk2bYyKptWPqEg==
Date:   Fri, 21 Jun 2019 00:58:34 +0000
Message-ID: <BYAPR04MB5816D6F4B36032ADEF6A8482E7E70@BYAPR04MB5816.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 9d6c1f47-2392-40f2-17bb-08d6f5e39685
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5320;
x-ms-traffictypediagnostic: BYAPR04MB5320:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5320B98ACBA4310D0B9A4D4CE7E70@BYAPR04MB5320.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(486006)(66476007)(6246003)(53546011)(102836004)(66446008)(8936002)(76176011)(81166006)(6506007)(99286004)(7696005)(14454004)(72206003)(81156014)(64756008)(66946007)(66556008)(316002)(2501003)(73956011)(14444005)(66066001)(478600001)(76116006)(5660300002)(52536014)(86362001)(26005)(33656002)(71200400001)(4326008)(8676002)(110136005)(256004)(446003)(186003)(305945005)(25786009)(3846002)(74316002)(7736002)(55016002)(68736007)(71190400001)(229853002)(6116002)(2906002)(9686003)(6436002)(53936002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5320;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GBCCCjadsWREu4wy/v/guiRVifZeN2X4pneJI9LZmPXcAqo+4ci3p82t93RRtNFgEcvRHmwTVLsBMZDsMGaiTbiCGM8+FgyGPUaWgLuqEKme99nMi8srNXOiEVt9aDYdHoJSTlg6R+QD+fXF4RMJXV4eniatZeUVV03hxxnkIIgfKatprQLV52zAlbKImWNUnbam3epoOwk7/qewZ1KWJI8yV73xjjJZFogRWJNYhi77Px4/mXLhO9hye1Qha2riQC7BSImeCqxmw7tsx3V13+uAHUMeO9XApXP6pX1b2OurJOR0sz5JniUbs2jfRjsXs7Idbf2toBp1WKpSXDUKt1yAmI9XjW5HbyKxWQNuwOjG7AqDtSfjDCx4d90LZ5UXwSuIL+QqPSK5+Wj0fr+aFopTsy4h/YtTaBaGAcWAMGE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6c1f47-2392-40f2-17bb-08d6f5e39685
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 00:58:34.9650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5320
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Bart,=0A=
=0A=
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
The REPORT_ZONES command is executed using scsi_execute_req(). Can we pass =
a=0A=
vmalloc-ed buffer to that function ? It does look like it since scsi_execut=
e_rq=0A=
calls bio_rq_map_kern() which then calls bio_map_kern() which goes through =
the=0A=
list of pages of the buffer. Just would like to confirm I understand this c=
orrectly.=0A=
=0A=
My concern with using vmalloc is that the worst case scenario will result i=
n all=0A=
pages of the buffer being non contiguous. In this case, since the report zo=
nes=0A=
command cannot be split, we would need to limit the allocation to max_segme=
nts *=0A=
page size, and that can be pretty small for some HBAs.=0A=
=0A=
Another reason I did not pursue the vmalloc route is that the processing of=
 the=0A=
report zones reply to transform zone information into struct blkzone is rea=
lly=0A=
painful to do with a vmalloced buffer as every page of the buffer needs to =
be=0A=
kmap()/kunmap(). The code was like that when REPORT ZONES was processed as =
a=0A=
BIO/request, but it was a lot of code for not much to be done. Or is there =
a=0A=
more elegant solution for in-kernel mapping of a vmalloc buffer ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
