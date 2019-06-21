Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C334E18E
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 10:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfFUIDr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Jun 2019 04:03:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11671 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfFUIDr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 21 Jun 2019 04:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561104226; x=1592640226;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TeZ26a+PxC3lQu+M7ez6ooy2C9mhPwXq4Ab//I5IsYI=;
  b=b1Jmd1aMRRhtWeSx8Vo0KY8jA8VEvINrZGwOmpg5yrJeleHxMmK/OT69
   m3YPFcCi2xefGRjwFJRU44o7fftjQHnNH4ym/luUa1YWzVBLqa+B+iBZN
   wkPWpXmD+s3DpFa4hTXk9zT1iDaw3enEPE+zBCQPk1ZC/nKErqpXYWJea
   VFsxlGRjsk2jnVvAHCL2Uj5d2pQeCmjOAo/7D7jV8We9WQsijsbbYWniB
   irQL92GgvB64N4PGE9ppo18AJZpIE2Hu/FxuadU+mLS1XP5n3GHuduTG7
   ChHD0GxT5P+ge0AAh2oIY6aYQJedhlwP2jZJMhbwJbcQBsVzNs3suXVWI
   A==;
X-IronPort-AV: E=Sophos;i="5.63,399,1557158400"; 
   d="scan'208";a="217505749"
Received: from mail-co1nam03lp2050.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.50])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2019 16:03:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeZ26a+PxC3lQu+M7ez6ooy2C9mhPwXq4Ab//I5IsYI=;
 b=dCFbIQpfe1Yw4LiNDzk+SoTxDNIZ9tP0xzvlepR3qGCckrBaZveSTaKg55vzRwPoC6byRjFC2yFDzkvPO+3PS3q9ZxTc+IbQnXqVb3I8f3bSJTUACVpmBDC7g5OZR97wF3h+9uFfpUGnLWngWGk5gNIAqeY4Cfmql92H8jAXktM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4837.namprd04.prod.outlook.com (52.135.240.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Fri, 21 Jun 2019 08:03:44 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 08:03:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] sd_zbc: Fix report zones buffer allocation
Thread-Topic: [PATCH] sd_zbc: Fix report zones buffer allocation
Thread-Index: AQHVJxsEGH+YXZvugk2bYyKptWPqEg==
Date:   Fri, 21 Jun 2019 08:03:43 +0000
Message-ID: <BYAPR04MB58169740768B79E99F3BB7DCE7E70@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190620034812.3254-1-damien.lemoal@wdc.com>
 <b6f250ad-0473-4643-8611-e395295e0379@acm.org>
 <BYAPR04MB5816D6F4B36032ADEF6A8482E7E70@BYAPR04MB5816.namprd04.prod.outlook.com>
 <18ab1c5d-338b-7464-46f2-911492aa548c@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcf5ab8f-6360-4f4b-9b06-08d6f61efb25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4837;
x-ms-traffictypediagnostic: BYAPR04MB4837:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB483727B0A34FD2E48BC1B6E9E7E70@BYAPR04MB4837.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(68736007)(25786009)(2906002)(86362001)(4326008)(64756008)(72206003)(52536014)(14444005)(71190400001)(14454004)(66066001)(6246003)(478600001)(71200400001)(6436002)(55016002)(53936002)(66946007)(66446008)(66556008)(256004)(66476007)(73956011)(76116006)(9686003)(305945005)(486006)(476003)(33656002)(2501003)(74316002)(229853002)(446003)(3846002)(8676002)(5660300002)(316002)(81166006)(76176011)(110136005)(102836004)(7696005)(53546011)(186003)(6506007)(26005)(99286004)(81156014)(8936002)(7736002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4837;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5ejHMyJmINsXEe7U+AJY8DlS9GM8sKcXc25WC4mOsodb09qz+Z8dWzwW37CjpBbo2nJV06AtOBV3Oze3p/RvRZ82WfbYDS1mXPbh6lX/3jOM6lYXP8N3w6W7o0B4RDHRpYAbotWh2YbitcP5Z6mFr48YicTjhZmzKNRBgN8MYhegEvle6uENbQflKSBhVO10XamUwil3gJLRpN+mgez1bUx9SWm2zC9TEMlXJCOCk/8jkc88oENJeccxgeYEFpu87KNYH+P4f6V+udKLGPR8cVX3bvf5i4CQh65cDEZS5QWr95RCAfF8rQAr53innmS4ste0N1bwei9XhAxen1vSf7Pwfla+ivY9wEvZ+bZ9UTNvVxUW95Fn2tUWbQaO0Ntsci1OHcrKtEF0k3cxBTRf5c0q3htPt3NyxnW2HxaftDg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf5ab8f-6360-4f4b-9b06-08d6f61efb25
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 08:03:43.9083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4837
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Bart,=0A=
=0A=
On 2019/06/21 12:46, Bart Van Assche wrote:=0A=
> On 6/20/19 5:58 PM, Damien Le Moal wrote:=0A=
>> The REPORT_ZONES command is executed using scsi_execute_req(). Can we pa=
ss a=0A=
>> vmalloc-ed buffer to that function ? It does look like it since scsi_exe=
cute_rq=0A=
>> calls bio_rq_map_kern() which then calls bio_map_kern() which goes throu=
gh the=0A=
>> list of pages of the buffer. Just would like to confirm I understand thi=
s correctly.=0A=
>>=0A=
>> My concern with using vmalloc is that the worst case scenario will resul=
t in all=0A=
>> pages of the buffer being non contiguous. In this case, since the report=
 zones=0A=
>> command cannot be split, we would need to limit the allocation to max_se=
gments *=0A=
>> page size, and that can be pretty small for some HBAs.=0A=
>>=0A=
>> Another reason I did not pursue the vmalloc route is that the processing=
 of the=0A=
>> report zones reply to transform zone information into struct blkzone is =
really=0A=
>> painful to do with a vmalloced buffer as every page of the buffer needs =
to be=0A=
>> kmap()/kunmap(). The code was like that when REPORT ZONES was processed =
as a=0A=
>> BIO/request, but it was a lot of code for not much to be done. Or is the=
re a=0A=
>> more elegant solution for in-kernel mapping of a vmalloc buffer ?=0A=
> =0A=
> Hi Damien,=0A=
> =0A=
> I don't think that bio_rq_map_kern() works with vmalloc-ed buffers. How =
=0A=
> about using is_vmalloc_addr() inside scsi_execute_req() to determine =0A=
> whether or not the buffer passed to that function has been allocated =0A=
> with vmalloc()? There may be other scsi_execute_req() callers that can =
=0A=
> benefit from passing a vmalloc-ed buffer to that function.=0A=
=0A=
Sure, we could do that. But since most (if not all) users of scsi_execute_r=
eq()=0A=
need only a very small buffer, I am not sure if this would be very useful.=
=0A=
=0A=
> Regarding the maximum segment size: is mpt3sas still the most popular =0A=
> HBA? Is the maximum segment size 128 for that driver? Is 128 * 4 KB =3D =
=0A=
> 512 KB big enough for the report zones buffer?=0A=
=0A=
Sure, it works, but compared to the target 1MB allocation that my patch has=
,=0A=
that doubles the number of requests needed for reporting the zones of an en=
tire=0A=
drive. Since this is however not used a lot, I guess it is okay. But still,=
 I do=0A=
not like very much slowing down revalidate() nor regular blkdev_report_zone=
s()=0A=
calls...=0A=
=0A=
> Regarding the loop that calls sd_zbc_parse_report(): are you sure that =
=0A=
> that kmap()/kunmap() calls would be necessary in that loop?=0A=
=0A=
No I am not sure. I will check again.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
