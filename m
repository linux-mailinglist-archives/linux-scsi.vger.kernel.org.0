Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BC756C583
	for <lists+linux-scsi@lfdr.de>; Sat,  9 Jul 2022 02:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiGIAlo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Jul 2022 20:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGIAln (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 Jul 2022 20:41:43 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3FD9B575;
        Fri,  8 Jul 2022 17:41:41 -0700 (PDT)
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1807045F99;
        Sat,  9 Jul 2022 00:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657327301; bh=hCnuRHoLYIoQ/nrPyCoP/E0IsiaBCAiuj0qZ69gaKe8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KYgaqOL+2Dzi9Bhy7q8jvhlVqVO3r7qqUdMkbnaTdmRt4qFmRCZB7pbvGQ/Im9Wje
         2EA4HYoXVld1W0mAdWTyIezLsEtxaLSF74YxZYbLY+ayYH7vF+J0LD8W7ulGBgv9wj
         KOlCyK0FEWo3W9pRPUjiIYsDB2fnVHKgmNctn84FB5AWDY7UpM0DGEQ99r/SGUJtWI
         k8AErvUM2O56FMouWyszMXFTQfDmY15JDoTS5DIZ1ZW68ZpkduuRN3mr80Y4sbZE3a
         wLW/rudN77/Sli0I59Olf+CtgLujSUi0Ax6HB0aMgOfSyQahl95GxM7i7+Bkmeg+p0
         mdfcAgmdY3yMQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BED23A00A0;
        Sat,  9 Jul 2022 00:41:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4165C40079;
        Sat,  9 Jul 2022 00:41:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gA+VXP2c";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQIYWUXGEqEP6dlSr1FXXgYrWS0WFIDQr5MXp5eFmU+uZyM4CoCH7+M9ISxcCVkBKYPzKrlozFquX8vrMbb1QnTVY7PLKin/EFD29WUZ6lKMGwdYo6dJxP4Cn5fFrF/XJh3QLZ/uhCkWVwePyf2qJnNaI2n4e1RTUkmdUf9FC3o1lkGpMtxJBA+z56THUqdquaqKsrVBgH0YlKQvWIJuS0fzc+K7o0ewYddcQ1hKewa8a1bw7pLsFbPq/AeMWO1QqJ7c8Hha8W4jDA+AwjQyknC7WtA/16W6UuOPlP71vZ1OAtsisgNGvG2rxNxPNO1jP8BdUvgXYulu893My1zo/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCnuRHoLYIoQ/nrPyCoP/E0IsiaBCAiuj0qZ69gaKe8=;
 b=mEfkYHgxHKALgvucVD9JzYpNv1KbhV3axLOO5S+DlwSfIj9zPGhNgffR33g8Av2sXh5FsJVYCZr683RxPDFWpfj7Xhc+FEgIugahB7N3MXVGI6/E6XN3EirvcHpR3TyP9Ot0HgZgFnYM+2eji1///tEWOHbBTJhzoS1Y918eV5r6zriw2Z5ipgSmSZC6oMFNaguVk+VNkVImludVt2RQQ81kGryNbgj9GfuintuM8VsrIzH9Le0UOT8rPUx2Y8qlZlMrCd+kCap9M7lsu3wtJLuEqyyp39XIowwCDmAxIZ6BLbbhcqtyPBBaUSpJWEaxQQigAwqP5kwsgTM0bhURLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCnuRHoLYIoQ/nrPyCoP/E0IsiaBCAiuj0qZ69gaKe8=;
 b=gA+VXP2cf88H+EuHlCBICwEvsCgZ95ZJQCfPxiSbws8PDD9BljR4Y2GdwPoaJ2A7o99uO7M0+oGjyLMPFDZSD80kwTxV2JNLMcEvp/KOT97SWLNCp4xAvoRIiGg2qfDoAidp1jzJIxFP7E60z1+oOl+7PsxaPXRdEL7gF8U+2Cw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH0PR12MB5028.namprd12.prod.outlook.com (2603:10b6:610:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 00:41:35 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5417.016; Sat, 9 Jul 2022
 00:41:35 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [PATCH 35/36] usb: gadget: f_tcm: Handle TASK_MANAGEMENT commands
Thread-Topic: [PATCH 35/36] usb: gadget: f_tcm: Handle TASK_MANAGEMENT
 commands
Thread-Index: AQHYkZFwMv/GTC98GUKJkFEMKV5Cma10MQsAgAEFGQA=
Date:   Sat, 9 Jul 2022 00:41:35 +0000
Message-ID: <67f119e5-281e-d8d0-ab30-4f2cef4de289@synopsys.com>
References: <cover.1657149962.git.Thinh.Nguyen@synopsys.com>
 <70aa4f59a7f9d9d0c770bf42a0723825fa564548.1657149962.git.Thinh.Nguyen@synopsys.com>
 <20220708090704.GM23838@yadro.com>
In-Reply-To: <20220708090704.GM23838@yadro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5af2810d-9281-4eed-5fae-08da6143c6c4
x-ms-traffictypediagnostic: CH0PR12MB5028:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ussdaW1ZbVuVaG4Ux+jJOvIG3QAnwUub9KfR9nIqO43lGWGVS6cCcKFozjl/tzzngOW3pZ0DEDWQFdPKDBiLnHGOPVFe7BgUsu4sxvwrZyGTetHkltjt87EfsrldSUHppKrU+R5gBeWeC5ysCzFUP6wtnT+986jKEpoH7gdAIfJGcQFnmd4FEubVbdCQutMcOl5zTyFR8CteCGyHOHvmSzbJ396kxA+2NnbKtfTMD/byJS4zApoPwI2rTLy6idtks+19HrsjRhj7U4XmTFFywtuNT5SnUM1m2/zmKefE95q8Nhh/qI2DiolezOxAKF0Awzf3ahWuGJyx195juIWmoR4wZMU54lJZMPl+VYRmVrIXiRHCsd119OPZrSCTtw41J5sTHEL/tpjqgCeu7XsQfPihWRE+W+e1YXJW4I66N9+8izVUzruyjbctl9RgbTHwy59gOsJASBRKvE/n0dWmGVH1kAzTXT4vBuXxYpFbjvVF3/A3p2dAtSwL1yp6RANwQUGiD9K0LpLkpRofFxyKT6ongfCxkqPvE1Cqgsg4jqDGc95lGr7Bk2nyEW+dGBNCZm9Dd9A2ixKGe9T0sNy3oP6V78Gn6h1UZo0vut0nq7yMemEs/c7actUs24eCvvr7HV4JMyqtGgQpaIWEfoNIMPwFp5r7cTWdrRGmiVaHu6ygBdRv7vnDNv4q6g0Dw4K3NMjycxe0BKWKbpP+EZ7LEH2Oyl2o0Zhq8vwgNsheO/P9rvIvjFsM7IYuXpaJnpRQk+VTBB6KDqaF+bwas7snxfnlJqpgCPaA5KvCV/agn1YCxrlZZ7H3cCPTd4v2WMUUBG4oHqqvOCrkYVFK5BbrYLLa9tLulFMGVZfZJk2d935b7fFPK8+ip4qPKcH0bCOQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(136003)(346002)(39860400002)(38100700002)(6506007)(38070700005)(122000001)(5660300002)(30864003)(316002)(54906003)(478600001)(6512007)(71200400001)(8936002)(186003)(110136005)(4326008)(76116006)(26005)(2616005)(66946007)(66556008)(31686004)(66446008)(83380400001)(8676002)(6486002)(64756008)(2906002)(36756003)(31696002)(41300700001)(86362001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azhZS1ZIc3B3QzI3VVVyUzBYMXlzVkhTdkY5eUtJODBuV3ZTMktGVHhrUENV?=
 =?utf-8?B?M3pRVFg3YWlKSmk4RnBqOG9GeDQzOU16eHJ2S2VjaHo0NllIeEdXUHRsTldt?=
 =?utf-8?B?eTd5U0dYbG5tQTQ0citiRUp6ZlVWamdqN21iSXU1eEMxelowcllETlUzR1NG?=
 =?utf-8?B?Zm9sNEl6OTVIeUV1V01ySkZBbWVnWnA3Z2E3dnNSdThkVmJ3V2lYU3JCczkx?=
 =?utf-8?B?SzcydXh6bGlIVUZpVkI3MUExY0tFTHBWdktSNXF1dXdGYmJweG90TkRLSi8w?=
 =?utf-8?B?VWxidzJBWG9ac21kYXNnTC81VHRXQ1p4WjJRZm1uTkxTSGlPdEdWVVlyVVlx?=
 =?utf-8?B?RGhPZTZ1NGtaQ2JHNTdtbEZTbVo0WTV5TDJpOFpJN3VidWtMUm1DaHl6WW1x?=
 =?utf-8?B?SkdERytOTmJvdVducXU0NllNMnc0YTZrTVVmRFh6QzltcUQ5L2paOERwbXo2?=
 =?utf-8?B?VDJlK2RsQ01mWjM1SUVMNGxxWCsvekluY1lIbktsSWcvNWFHeU80STVxay8v?=
 =?utf-8?B?dzgvL2I1bkI3Y2c4QjZRSWwxbWZOUmdIUERwVmJqd0lvblhvU2p0czIzRG4w?=
 =?utf-8?B?UjVuWU84NFBpek5hZlk4WW1YcnR5bkRWQlY3cnFCUjYyNDI4cndkOGViNTVl?=
 =?utf-8?B?cUFvUVJBQnRRM0g0ZTgxY3BEalhpTXFPVytVL21PM1d5a3FGeTlJY3JUbkda?=
 =?utf-8?B?RDlLNWU5OG8rOTFZT2NmdjlLQ2toTWFYdlVSOXpKRzdWZGRJTEJ5N2ZwcGt6?=
 =?utf-8?B?emoyZ09idjRwRDFRak5wSllMV05WUkhDckxmeUNlMWdybytFVUFPVWg4VXVS?=
 =?utf-8?B?dFpNdndtcWo2TWtxaVZiREFHUTh5dHVTbWtGdkhRdnJRaUJyUytWSFZ4ZzNN?=
 =?utf-8?B?QjBJWjdIR2EyS3VoZGtVcVJWQ3ZGK2xOdDJpczZvYklVS1JDWmFGYU1RS1V3?=
 =?utf-8?B?SnVVeGpYaUVSdEVmY1p5dllQd3NWTGtLT1RFSkhCL1YyU1U5dGJpQ0llWEtF?=
 =?utf-8?B?UnY3NUl2QjY3QzZQM0QybzNhSVBCeFlnUHhUNi9kZGd0TVYzalRiQUVua0hP?=
 =?utf-8?B?ejhtM1JNT2U2Ynp2ZHBrMkZjeFo2TERGRzVZV2ZNU0RlZkF6MFdNbDZYK2RN?=
 =?utf-8?B?TWJ2TjBjMldWV0l1WmRDOERYUjZlMUZRUXBCdzVEVFJwcnB4UFE2ZUdDZzNG?=
 =?utf-8?B?WUVpK1dHS0lpdERyR0paeVJ1V25sZjRqQlZ3dVZJMHFvYnlwT2d1MVZVUFJu?=
 =?utf-8?B?MUxLSXFadTE2ODNvS2JRRHFSV2ZMS2ZQdFpmRGlVL2VvZEVla2ZTL0lNb1dx?=
 =?utf-8?B?L0hYdTdXcXdyY2dJMTdrSFlPeGkrRTJvNmxUREpjS2hxZjlLdlpWekl6Skhz?=
 =?utf-8?B?TllvRy9DQzRnbVBkTkZtMEpOTGlHNVNZMENVK3BPZTVPTGpoeEQ5eEpSSjRt?=
 =?utf-8?B?UEFXRGRTMWF5NXA2WGNycW4wNzRpSERYWDhMR1lSb1JqeTVYUU05OFpiWVoz?=
 =?utf-8?B?L0hqbEpmbHR3elh1SlVlNWtpZCt4R21TMkp0b0tqZWovRmQwa25OUlZMVnVv?=
 =?utf-8?B?dEZMQ2p6OGIrcmkzb3VvQ3gvaTNSTGtxSmNBMVZlNjBqQ1I1R2dVdEhQb2N2?=
 =?utf-8?B?L3YvYzdqWlVvcWFIUndwL21OZVI5UkFudUxka3VJTFZ0S3VxRFFYa3JjS2p4?=
 =?utf-8?B?ZjIrMVVqK3Rkd1FEclZJS0xzT2lpb1lxajFQa1FDcWtKaXo2dEJ5OEpaS2JD?=
 =?utf-8?B?VVZEUmFwQjdIWWpzWVRJMHROOVFmM3hRV083elc1cjhZYVFmcGliKzd1TW10?=
 =?utf-8?B?ckVBSW0xMXk4NUFmSmNsYmY4Nks4RDZka0JaQTVvQlB0SEpVNGdlMlFQOEpx?=
 =?utf-8?B?TEdFRGZWSitLd1hKYlArM2FUcFVFTU93SmVZOVN6MVlFUEhmMU9EaWQvb0VO?=
 =?utf-8?B?anNpc3J5L2lFbUxEeWw3SG9ubVFWS2hGNHRZc1B4bm1lTHlRTENWMncwd09p?=
 =?utf-8?B?Uml0T1IycC9VN3krTG1TQVFiaVJHSUxGODh0OEVGQUJUdko1Um9GcTFaUUFV?=
 =?utf-8?B?MmprYVo1K01uOThlZHQzcFJTcDM1TWg1SGxxWFlUakJqTEpIZWlqRy9Td1J1?=
 =?utf-8?Q?p20k5WRuJbhSaoosuAWuf9EJC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4227123C2945840BBA2905E6B1A3E55@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af2810d-9281-4eed-5fae-08da6143c6c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 00:41:35.1495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPV63H6mqiUXu7j9XemCLFza6ETXDOoGmgATcaj3DKbxiGszPsQZaRWm+9Ey3e5+g37/qkEM87taDpBQ8XjvaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

T24gNy84LzIwMjIsIERtaXRyeSBCb2dkYW5vdiB3cm90ZToNCj4gT24gV2VkLCBKdWwgMDYsIDIw
MjIgYXQgMDQ6Mzg6MDFQTSAtMDcwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gSGFuZGxlIHRh
cmdldF9jb3JlX2ZhYnJpY19vcHMgVEFTSyBNQU5BR0VNRU5UIGZ1bmN0aW9ucyBhbmQgdGhlaXIN
Cj4+IHJlc3BvbnNlLiBJZiBhIFRBU0sgTUFOQUdFTUVOVCBjb21tYW5kIGlzIHJlY2VpdmVkLCB0
aGUgZHJpdmVyIHdpbGwNCj4+IGludGVycHJldCB0aGUgZnVuY3Rpb24gVE1GXyosIHRyYW5zbGF0
ZSB0byBUTVJfKiwgYW5kIGZpcmUgb2ZmIGEgY29tbWFuZA0KPj4gd29yayBleGVjdXRpbmcgdGFy
Z2V0X3N1Ym1pdF90bXIoKS4gT24gY29tcGxldGlvbiwgaXQgd2lsbCBoYW5kbGUgdGhlDQo+PiBU
QVNLIE1BTkFHRU1FTlQgcmVzcG9uc2UgdGhyb3VnaCB1YXNwX3NlbmRfdG1fcmVzcG9uc2UoKS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5
cy5jb20+DQo+PiAtLS0NCj4+IE5PVEU6IEkgYXBwb2xvZ2l6ZSBmb3IgdGhpcyBiaWcgcGF0Y2gu
IEkgZmVlbCB0aGF0IHRoaXMgZmVhdHVyZSBuZWVkcyB0byBiZQ0KPj4gdmlld2VkIGluIGl0cyBl
bnRpcmV0eSB0byBzZWUgdGhlIHdob2xlIHBpY3R1cmUgYW5kIGVhc2llciByZXZpZXcuDQo+Pg0K
Pj4NCj4+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdGNtLmMgfCAyNjAgKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLQ0KPj4gICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24v
dGNtLmggICB8ICAgNyArLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDI0MSBpbnNlcnRpb25zKCsp
LCAyNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL2ZfdGNtLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYw0K
Pj4gaW5kZXggZmEwOTk5OWFkZGE3Li5hNjg0MzZmOTdmOTEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYw0KPj4gKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL2ZfdGNtLmMNCj4+IEBAIC0xMiw2ICsxMiw3IEBADQo+PiAgICNpbmNsdWRl
IDxsaW51eC9zdHJpbmcuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2NvbmZpZ2ZzLmg+DQo+PiAg
ICNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0K
Pj4gICAjaW5jbHVkZSA8bGludXgvdXNiL2NoOS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvdXNi
L2NvbXBvc2l0ZS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvdXNiL2dhZGdldC5oPg0KPj4gQEAg
LTQ2Miw2ICs0NjMsNTMgQEAgc3RhdGljIGludCB1c2JnX2JvdF9zZXR1cChzdHJ1Y3QgdXNiX2Z1
bmN0aW9uICpmLA0KPj4gICANCj4+ICAgLyogU3RhcnQgdWFzLmMgY29kZSAqLw0KPj4gICANCj4+
ICtzdGF0aWMgaW50IHRjbV90b191YXNwX3Jlc3BvbnNlKGVudW0gdGNtX3RtcnNwX3RhYmxlIGNv
ZGUpDQo+PiArew0KPj4gKwlzd2l0Y2ggKGNvZGUpIHsNCj4+ICsJY2FzZSBUTVJfRlVOQ1RJT05f
RkFJTEVEOg0KPj4gKwkJcmV0dXJuIFJDX1RNRl9GQUlMRUQ7DQo+PiArCWNhc2UgVE1SX0ZVTkNU
SU9OX0NPTVBMRVRFOg0KPj4gKwkJcmV0dXJuIFJDX1RNRl9DT01QTEVURTsNCj4+ICsJY2FzZSBU
TVJfRlVOQ1RJT05fUkVKRUNURUQ6DQo+PiArCQlyZXR1cm4gUkNfVE1GX05PVF9TVVBQT1JURUQ7
DQo+PiArCWNhc2UgVE1SX0xVTl9ET0VTX05PVF9FWElTVDoNCj4+ICsJCXJldHVybiBSQ19JTkNP
UlJFQ1RfTFVOOw0KPj4gKwljYXNlIFRNUl9PVkVSTEFQUEVEX1RBR19BVFRFTVBURUQ6DQo+PiAr
CQlyZXR1cm4gUkNfT1ZFUkxBUFBFRF9UQUc7DQo+PiArCWNhc2UgVE1SX1RBU0tfRE9FU19OT1Rf
RVhJU1Q6DQo+PiArCQlyZXR1cm4gUkNfSU5WQUxJRF9JTkZPX1VOSVQ7DQo+PiArCWNhc2UgVE1S
X1RBU0tfTUdNVF9GVU5DVElPTl9OT1RfU1VQUE9SVEVEOg0KPj4gKwlkZWZhdWx0Og0KPj4gKwkJ
cmV0dXJuIFJDX1RNRl9OT1RfU1VQUE9SVEVEOw0KPj4gKwl9DQo+PiArfQ0KPj4gKw0KPj4gK3N0
YXRpYyB1bnNpZ25lZCBjaGFyIHVhc3BfdG9fdGNtX2Z1bmMoaW50IGNvZGUpDQo+PiArew0KPj4g
Kwlzd2l0Y2ggKGNvZGUpIHsNCj4+ICsJY2FzZSBUTUZfQUJPUlRfVEFTSzoNCj4+ICsJCXJldHVy
biBUTVJfQUJPUlRfVEFTSzsNCj4+ICsJY2FzZSBUTUZfQUJPUlRfVEFTS19TRVQ6DQo+PiArCQly
ZXR1cm4gVE1SX0FCT1JUX1RBU0tfU0VUOw0KPj4gKwljYXNlIFRNRl9DTEVBUl9UQVNLX1NFVDoN
Cj4+ICsJCXJldHVybiBUTVJfQ0xFQVJfVEFTS19TRVQ7DQo+PiArCWNhc2UgVE1GX0xPR0lDQUxf
VU5JVF9SRVNFVDoNCj4+ICsJCXJldHVybiBUTVJfTFVOX1JFU0VUOw0KPj4gKwljYXNlIFRNRl9J
X1RfTkVYVVNfUkVTRVQ6DQo+PiArCQlyZXR1cm4gVE1SX0lfVF9ORVhVU19SRVNFVDsNCj4+ICsJ
Y2FzZSBUTUZfQ0xFQVJfQUNBOg0KPj4gKwkJcmV0dXJuIFRNUl9DTEVBUl9BQ0E7DQo+PiArCWNh
c2UgVE1GX1FVRVJZX1RBU0s6DQo+PiArCQlyZXR1cm4gVE1SX1FVRVJZX1RBU0s7DQo+PiArCWNh
c2UgVE1GX1FVRVJZX1RBU0tfU0VUOg0KPj4gKwkJcmV0dXJuIFRNUl9RVUVSWV9UQVNLX1NFVDsN
Cj4+ICsJY2FzZSBUTUZfUVVFUllfQVNZTkNfRVZFTlQ6DQo+PiArCQlyZXR1cm4gVE1SX1FVRVJZ
X0FTWU5DX0VWRU5UOw0KPj4gKwlkZWZhdWx0Og0KPj4gKwkJcmV0dXJuIFRNUl9VTktOT1dOOw0K
Pj4gKwl9DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgdm9pZCB1YXNwX2NsZWFudXBfb25lX3N0
cmVhbShzdHJ1Y3QgZl91YXMgKmZ1LCBzdHJ1Y3QgdWFzX3N0cmVhbSAqc3RyZWFtKQ0KPj4gICB7
DQo+PiAgIAkvKiBXZSBoYXZlIGVpdGhlciBhbGwgdGhyZWUgYWxsb2NhdGVkIG9yIG5vbmUgKi8N
Cj4+IEBAIC01MDYsNiArNTU0LDExIEBAIHN0YXRpYyB2b2lkIHVhc3BfY2xlYW51cF9vbGRfYWx0
KHN0cnVjdCBmX3VhcyAqZnUpDQo+PiAgIAl1YXNwX2ZyZWVfY21kcmVxKGZ1KTsNCj4+ICAgfQ0K
Pj4gICANCj4+ICtzdGF0aWMgc3RydWN0IHVhc19zdHJlYW0gKnVhc3BfZ2V0X3N0cmVhbV9ieV90
YWcoc3RydWN0IGZfdWFzICpmdSwgdTE2IHRhZykNCj4+ICt7DQo+PiArCXJldHVybiAmZnUtPnN0
cmVhbVt0YWcgJSBVU0JHX05VTV9DTURTXTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lk
IHVhc3Bfc3RhdHVzX2RhdGFfY21wbChzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1
ZXN0ICpyZXEpOw0KPj4gICANCj4+ICAgc3RhdGljIGludCB1YXNwX3ByZXBhcmVfcl9yZXF1ZXN0
KHN0cnVjdCB1c2JnX2NtZCAqY21kKQ0KPj4gQEAgLTUxMyw3ICs1NjYsNyBAQCBzdGF0aWMgaW50
IHVhc3BfcHJlcGFyZV9yX3JlcXVlc3Qoc3RydWN0IHVzYmdfY21kICpjbWQpDQo+PiAgIAlzdHJ1
Y3Qgc2VfY21kICpzZV9jbWQgPSAmY21kLT5zZV9jbWQ7DQo+PiAgIAlzdHJ1Y3QgZl91YXMgKmZ1
ID0gY21kLT5mdTsNCj4+ICAgCXN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQgPSBmdWFzX3RvX2dh
ZGdldChmdSk7DQo+PiAtCXN0cnVjdCB1YXNfc3RyZWFtICpzdHJlYW0gPSBjbWQtPnN0cmVhbTsN
Cj4+ICsJc3RydWN0IHVhc19zdHJlYW0gKnN0cmVhbSA9IHVhc3BfZ2V0X3N0cmVhbV9ieV90YWco
ZnUsIGNtZC0+dGFnKTsNCj4+ICAgDQo+PiAgIAlpZiAoIWdhZGdldC0+c2dfc3VwcG9ydGVkKSB7
DQo+PiAgIAkJY21kLT5kYXRhX2J1ZiA9IGttYWxsb2Moc2VfY21kLT5kYXRhX2xlbmd0aCwgR0ZQ
X0FUT01JQyk7DQo+PiBAQCAtNTQ2LDcgKzU5OSw3IEBAIHN0YXRpYyB2b2lkIHVhc3BfcHJlcGFy
ZV9zdGF0dXMoc3RydWN0IHVzYmdfY21kICpjbWQpDQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBzZV9j
bWQgKnNlX2NtZCA9ICZjbWQtPnNlX2NtZDsNCj4+ICAgCXN0cnVjdCBzZW5zZV9pdSAqaXUgPSAm
Y21kLT5zZW5zZV9pdTsNCj4+IC0Jc3RydWN0IHVhc19zdHJlYW0gKnN0cmVhbSA9IGNtZC0+c3Ry
ZWFtOw0KPj4gKwlzdHJ1Y3QgdWFzX3N0cmVhbSAqc3RyZWFtID0gdWFzcF9nZXRfc3RyZWFtX2J5
X3RhZyhjbWQtPmZ1LCBjbWQtPnRhZyk7DQo+PiAgIA0KPj4gICAJY21kLT5zdGF0ZSA9IFVBU1Bf
UVVFVUVfQ09NTUFORDsNCj4+ICAgCWl1LT5pdV9pZCA9IElVX0lEX1NUQVRVUzsNCj4+IEBAIC01
NjUsMTEgKzYxOCwzNiBAQCBzdGF0aWMgdm9pZCB1YXNwX3ByZXBhcmVfc3RhdHVzKHN0cnVjdCB1
c2JnX2NtZCAqY21kKQ0KPj4gICAJc3RyZWFtLT5yZXFfc3RhdHVzLT5jb21wbGV0ZSA9IHVhc3Bf
c3RhdHVzX2RhdGFfY21wbDsNCj4+ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgdm9pZCB1YXNwX3By
ZXBhcmVfcmVzcG9uc2Uoc3RydWN0IHVzYmdfY21kICpjbWQpDQo+PiArew0KPj4gKwlzdHJ1Y3Qg
c2VfY21kICpzZV9jbWQgPSAmY21kLT5zZV9jbWQ7DQo+PiArCXN0cnVjdCByZXNwb25zZV9pdSAq
cnNwX2l1ID0gJmNtZC0+cmVzcG9uc2VfaXU7DQo+PiArCXN0cnVjdCB1YXNfc3RyZWFtICpzdHJl
YW0gPSB1YXNwX2dldF9zdHJlYW1fYnlfdGFnKGNtZC0+ZnUsIGNtZC0+dGFnKTsNCj4+ICsNCj4+
ICsJY21kLT5zdGF0ZSA9IFVBU1BfUVVFVUVfQ09NTUFORDsNCj4+ICsJcnNwX2l1LT5pdV9pZCA9
IElVX0lEX1JFU1BPTlNFOw0KPj4gKwlyc3BfaXUtPnRhZyA9IGNwdV90b19iZTE2KGNtZC0+dGFn
KTsNCj4+ICsNCj4+ICsJaWYgKGNtZC0+dG1yX3JzcCAhPSBUTVJfUkVTUE9OU0VfVU5LTk9XTikN
Cj4+ICsJCXJzcF9pdS0+cmVzcG9uc2VfY29kZSA9DQo+PiArCQkJdGNtX3RvX3Vhc3BfcmVzcG9u
c2UoY21kLT50bXJfcnNwKTsNCj4+ICsJZWxzZQ0KPj4gKwkJcnNwX2l1LT5yZXNwb25zZV9jb2Rl
ID0NCj4+ICsJCQl0Y21fdG9fdWFzcF9yZXNwb25zZShzZV9jbWQtPnNlX3Rtcl9yZXEtPnJlc3Bv
bnNlKTsNCj4+ICsNCj4+ICsJc3RyZWFtLT5yZXFfc3RhdHVzLT5pc19sYXN0ID0gMTsNCj4+ICsJ
c3RyZWFtLT5yZXFfc3RhdHVzLT5zdHJlYW1faWQgPSBjbWQtPnRhZzsNCj4+ICsJc3RyZWFtLT5y
ZXFfc3RhdHVzLT5jb250ZXh0ID0gY21kOw0KPj4gKwlzdHJlYW0tPnJlcV9zdGF0dXMtPmxlbmd0
aCA9IHNpemVvZihzdHJ1Y3QgcmVzcG9uc2VfaXUpOw0KPj4gKwlzdHJlYW0tPnJlcV9zdGF0dXMt
PmJ1ZiA9IHJzcF9pdTsNCj4+ICsJc3RyZWFtLT5yZXFfc3RhdHVzLT5jb21wbGV0ZSA9IHVhc3Bf
c3RhdHVzX2RhdGFfY21wbDsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkIHVhc3Bfc3Rh
dHVzX2RhdGFfY21wbChzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEp
DQo+PiAgIHsNCj4+ICAgCXN0cnVjdCB1c2JnX2NtZCAqY21kID0gcmVxLT5jb250ZXh0Ow0KPj4g
LQlzdHJ1Y3QgdWFzX3N0cmVhbSAqc3RyZWFtID0gY21kLT5zdHJlYW07DQo+PiAgIAlzdHJ1Y3Qg
Zl91YXMgKmZ1ID0gY21kLT5mdTsNCj4+ICsJc3RydWN0IHVhc19zdHJlYW0gKnN0cmVhbSA9IHVh
c3BfZ2V0X3N0cmVhbV9ieV90YWcoZnUsIGNtZC0+dGFnKTsNCj4+ICAgCXN0cnVjdCBzZV9zZXNz
aW9uICpzZV9zZXNzID0gY21kLT5zZV9jbWQuc2Vfc2VzczsNCj4+ICAgCWludCByZXQ7DQo+PiAg
IA0KPj4gQEAgLTYwNCw2ICs2ODIsNyBAQCBzdGF0aWMgdm9pZCB1YXNwX3N0YXR1c19kYXRhX2Nt
cGwoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KPj4gICAJCWJy
ZWFrOw0KPj4gICANCj4+ICAgCWNhc2UgVUFTUF9RVUVVRV9DT01NQU5EOg0KPj4gKwkJc3RyZWFt
LT5jbWQgPSBOVUxMOw0KPj4gICANCj4+ICAgCQl0YXJnZXRfZnJlZV90YWcoc2Vfc2VzcywgJmNt
ZC0+c2VfY21kKTsNCj4+ICAgCQl0cmFuc3BvcnRfZ2VuZXJpY19mcmVlX2NtZCgmY21kLT5zZV9j
bWQsIDApOw0KPj4gQEAgLTYxNyw2ICs2OTYsNyBAQCBzdGF0aWMgdm9pZCB1YXNwX3N0YXR1c19k
YXRhX2NtcGwoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KPj4g
ICAJcmV0dXJuOw0KPj4gICANCj4+ICAgY2xlYW51cDoNCj4+ICsJc3RyZWFtLT5jbWQgPSBOVUxM
Ow0KPj4gICAJdGFyZ2V0X2ZyZWVfdGFnKHNlX3Nlc3MsICZjbWQtPnNlX2NtZCk7DQo+PiAgIAl0
cmFuc3BvcnRfZ2VuZXJpY19mcmVlX2NtZCgmY21kLT5zZV9jbWQsIDApOw0KPj4gICB9DQo+PiBA
QCAtNjI0LDcgKzcwNCw3IEBAIHN0YXRpYyB2b2lkIHVhc3Bfc3RhdHVzX2RhdGFfY21wbChzdHJ1
Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEpDQo+PiAgIHN0YXRpYyBpbnQg
dWFzcF9zZW5kX3N0YXR1c19yZXNwb25zZShzdHJ1Y3QgdXNiZ19jbWQgKmNtZCkNCj4+ICAgew0K
Pj4gICAJc3RydWN0IGZfdWFzICpmdSA9IGNtZC0+ZnU7DQo+PiAtCXN0cnVjdCB1YXNfc3RyZWFt
ICpzdHJlYW0gPSBjbWQtPnN0cmVhbTsNCj4+ICsJc3RydWN0IHVhc19zdHJlYW0gKnN0cmVhbSA9
IHVhc3BfZ2V0X3N0cmVhbV9ieV90YWcoZnUsIGNtZC0+dGFnKTsNCj4+ICAgCXN0cnVjdCBzZW5z
ZV9pdSAqaXUgPSAmY21kLT5zZW5zZV9pdTsNCj4+ICAgDQo+PiAgIAlpdS0+dGFnID0gY3B1X3Rv
X2JlMTYoY21kLT50YWcpOw0KPj4gQEAgLTYzMywxMCArNzEzLDIyIEBAIHN0YXRpYyBpbnQgdWFz
cF9zZW5kX3N0YXR1c19yZXNwb25zZShzdHJ1Y3QgdXNiZ19jbWQgKmNtZCkNCj4+ICAgCXJldHVy
biB1c2JfZXBfcXVldWUoZnUtPmVwX3N0YXR1cywgc3RyZWFtLT5yZXFfc3RhdHVzLCBHRlBfQVRP
TUlDKTsNCj4+ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgaW50IHVhc3Bfc2VuZF90bV9yZXNwb25z
ZShzdHJ1Y3QgdXNiZ19jbWQgKmNtZCkNCj4+ICt7DQo+PiArCXN0cnVjdCBmX3VhcyAqZnUgPSBj
bWQtPmZ1Ow0KPj4gKwlzdHJ1Y3QgdWFzX3N0cmVhbSAqc3RyZWFtID0gdWFzcF9nZXRfc3RyZWFt
X2J5X3RhZyhmdSwgY21kLT50YWcpOw0KPj4gKwlzdHJ1Y3QgcmVzcG9uc2VfaXUgKml1ID0gJmNt
ZC0+cmVzcG9uc2VfaXU7DQo+PiArDQo+PiArCWl1LT50YWcgPSBjcHVfdG9fYmUxNihjbWQtPnRh
Zyk7DQo+PiArCWNtZC0+ZnUgPSBmdTsNCj4+ICsJdWFzcF9wcmVwYXJlX3Jlc3BvbnNlKGNtZCk7
DQo+PiArCXJldHVybiB1c2JfZXBfcXVldWUoZnUtPmVwX3N0YXR1cywgc3RyZWFtLT5yZXFfc3Rh
dHVzLCBHRlBfQVRPTUlDKTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyBpbnQgdWFzcF9zZW5k
X3JlYWRfcmVzcG9uc2Uoc3RydWN0IHVzYmdfY21kICpjbWQpDQo+PiAgIHsNCj4+ICAgCXN0cnVj
dCBmX3VhcyAqZnUgPSBjbWQtPmZ1Ow0KPj4gLQlzdHJ1Y3QgdWFzX3N0cmVhbSAqc3RyZWFtID0g
Y21kLT5zdHJlYW07DQo+PiArCXN0cnVjdCB1YXNfc3RyZWFtICpzdHJlYW0gPSB1YXNwX2dldF9z
dHJlYW1fYnlfdGFnKGZ1LCBjbWQtPnRhZyk7DQo+PiAgIAlzdHJ1Y3Qgc2Vuc2VfaXUgKml1ID0g
JmNtZC0+c2Vuc2VfaXU7DQo+PiAgIAlpbnQgcmV0Ow0KPj4gICANCj4+IEBAIC02ODIsNyArNzc0
LDcgQEAgc3RhdGljIGludCB1YXNwX3NlbmRfcmVhZF9yZXNwb25zZShzdHJ1Y3QgdXNiZ19jbWQg
KmNtZCkNCj4+ICAgc3RhdGljIGludCB1YXNwX3NlbmRfd3JpdGVfcmVxdWVzdChzdHJ1Y3QgdXNi
Z19jbWQgKmNtZCkNCj4+ICAgew0KPj4gICAJc3RydWN0IGZfdWFzICpmdSA9IGNtZC0+ZnU7DQo+
PiAtCXN0cnVjdCB1YXNfc3RyZWFtICpzdHJlYW0gPSBjbWQtPnN0cmVhbTsNCj4+ICsJc3RydWN0
IHVhc19zdHJlYW0gKnN0cmVhbSA9IHVhc3BfZ2V0X3N0cmVhbV9ieV90YWcoZnUsIGNtZC0+dGFn
KTsNCj4+ICAgCXN0cnVjdCBzZW5zZV9pdSAqaXUgPSAmY21kLT5zZW5zZV9pdTsNCj4+ICAgCWlu
dCByZXQ7DQo+PiAgIA0KPj4gQEAgLTk0Myw4ICsxMDM1LDEwIEBAIHN0YXRpYyB2b2lkIHVzYmdf
ZGF0YV93cml0ZV9jbXBsKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJl
cSkNCj4+ICAgew0KPj4gICAJc3RydWN0IHVzYmdfY21kICpjbWQgPSByZXEtPmNvbnRleHQ7DQo+
PiAgIAlzdHJ1Y3Qgc2VfY21kICpzZV9jbWQgPSAmY21kLT5zZV9jbWQ7DQo+PiArCXN0cnVjdCB1
YXNfc3RyZWFtICpzdHJlYW0gPSB1YXNwX2dldF9zdHJlYW1fYnlfdGFnKGNtZC0+ZnUsIGNtZC0+
dGFnKTsNCj4+ICAgDQo+PiAgIAlpZiAocmVxLT5zdGF0dXMgPT0gLUVTSFVURE9XTikgew0KPj4g
KwkJc3RyZWFtLT5jbWQgPSBOVUxMOw0KPj4gICAJCXRhcmdldF9mcmVlX3RhZyhzZV9jbWQtPnNl
X3Nlc3MsIHNlX2NtZCk7DQo+PiAgIAkJdHJhbnNwb3J0X2dlbmVyaWNfZnJlZV9jbWQoJmNtZC0+
c2VfY21kLCAwKTsNCj4+ICAgCQlyZXR1cm47DQo+PiBAQCAtOTYyLDYgKzEwNTYsNyBAQCBzdGF0
aWMgdm9pZCB1c2JnX2RhdGFfd3JpdGVfY21wbChzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVz
Yl9yZXF1ZXN0ICpyZXEpDQo+PiAgIAkJCQlzZV9jbWQtPmRhdGFfbGVuZ3RoKTsNCj4+ICAgCX0N
Cj4+ICAgDQo+PiArCWNtZC0+c3RhdGUgPSBVQVNQX1FVRVVFX0NPTU1BTkQ7DQo+PiAgIAl0YXJn
ZXRfZXhlY3V0ZV9jbWQoc2VfY21kKTsNCj4+ICAgCXJldHVybjsNCj4+ICAgDQo+PiBAQCAtMTA0
Miw5ICsxMTM3LDY2IEBAIHN0YXRpYyBpbnQgdXNiZ19zZW5kX3JlYWRfcmVzcG9uc2Uoc3RydWN0
IHNlX2NtZCAqc2VfY21kKQ0KPj4gICAJCXJldHVybiB1YXNwX3NlbmRfcmVhZF9yZXNwb25zZShj
bWQpOw0KPj4gICB9DQo+PiAgIA0KPj4gLXN0YXRpYyB2b2lkIHVzYmdfY21kX3dvcmsoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQ0KPj4gK3N0YXRpYyB2b2lkIHVzYmdfc3VibWl0X3RtcihzdHJ1
Y3QgdXNiZ19jbWQgKmNtZCkNCj4+ICt7DQo+PiArCXN0cnVjdCBzZV9jbWQgKnNlX2NtZDsNCj4+
ICsJc3RydWN0IHRjbV91c2JnX25leHVzICp0dl9uZXh1czsNCj4+ICsJc3RydWN0IHVhc19zdHJl
YW0gKnN0cmVhbTsNCj4+ICsJaW50IGZsYWdzID0gVEFSR0VUX1NDRl9BQ0tfS1JFRjsNCj4+ICsN
Cj4+ICsJc2VfY21kID0gJmNtZC0+c2VfY21kOw0KPj4gKwl0dl9uZXh1cyA9IGNtZC0+ZnUtPnRw
Zy0+dHBnX25leHVzOw0KPj4gKwlzdHJlYW0gPSB1YXNwX2dldF9zdHJlYW1fYnlfdGFnKGNtZC0+
ZnUsIGNtZC0+dGFnKTsNCj4+ICsNCj4+ICsJLyogRmFpbHVyZSBkZXRlY3RlZCBieSBmX3RjbSAq
Lw0KPj4gKwlpZiAoY21kLT50bXJfcnNwICE9IFRNUl9SRVNQT05TRV9VTktOT1dOKSB7DQo+PiAr
CQlpZiAoY21kLT50bXJfcnNwID09IFRNUl9PVkVSTEFQUEVEX1RBR19BVFRFTVBURUQpIHsNCj4+
ICsJCQkvKg0KPj4gKwkJCSAqIFRoZXJlJ3Mgbm8gZ3VhcmFudGVlIG9mIGEgbWF0Y2hpbmcgY29t
cGxldGlvbiBvcmRlcg0KPj4gKwkJCSAqIGJldHdlZW4gZGlmZmVyZW50IGVuZHBvaW50cy4gaS5l
LiBUaGUgZGV2aWNlIG1heQ0KPj4gKwkJCSAqIHJlY2VpdmUgYSBuZXcgKENEQikgY29tbWFuZCBy
ZXF1ZXN0IGNvbXBsZXRpb24gb2YgdGhlDQo+PiArCQkJICogY29tbWFuZCBlbmRwb2ludCBiZWZv
cmUgaXQgZ2V0cyBub3RpZmllZCBvZiB0aGUNCj4+ICsJCQkgKiBwcmV2aW91cyBjb21tYW5kIHN0
YXR1cyBjb21wbGV0aW9uIGZyb20gYSBzdGF0dXMNCj4+ICsJCQkgKiBlbmRwb2ludC4gVGhlIGRy
aXZlciBzdGlsbCBuZWVkcyB0byBkZXRlY3QNCj4+ICsJCQkgKiBtaXNiZWhhdmluZyBob3N0IGFu
ZCByZXNwb25kIHdpdGggYW4gb3ZlcmxhcCBjb21tYW5kDQo+PiArCQkJICogdGFnLiBUbyBwcmV2
ZW50IGZhbHNlIG92ZXJsYXBwZWQgdGFnIGZhaWx1cmUsIGdpdmUNCj4+ICsJCQkgKiB0aGUgYWN0
aXZlIGFuZCBtYXRjaGluZyBzdHJlYW0gaWQgYSBzaG9ydCB0aW1lICgxbXMpDQo+PiArCQkJICog
dG8gY29tcGxldGUgYmVmb3JlIHJlc3BvbmQgd2l0aCBvdmVybGFwcGVkIGNvbW1hbmQNCj4+ICsJ
CQkgKiBmYWlsdXJlLg0KPj4gKwkJCSAqLw0KPj4gKwkJCW1zbGVlcCgxKTsNCj4+ICsNCj4+ICsJ
CQkvKiBJZiB0aGUgc3RyZWFtIGlzIGNvbXBsZXRlZCwgcmV0cnkgdGhlIGNvbW1hbmQgKi8NCj4+
ICsJCQlpZiAoIXN0cmVhbS0+Y21kKSB7DQo+PiArCQkJCXVzYmdfc3VibWl0X2NvbW1hbmQoY21k
LT5mdSwgY21kLT5yZXEpOw0KPj4gKwkJCQlyZXR1cm47DQo+PiArCQkJfQ0KPj4gKw0KPj4gKwkJ
CS8qIE92ZXJsYXAgY29tbWFuZCB0YWcgZGV0ZWN0ZWQuIEFib3J0IGNvbW1hbmQuICovDQo+PiAr
CQkJY21kLT5zdGF0ZSA9IFVBU1BfUVVFVUVfQ09NTUFORDsNCj4+ICsJCQlzdHJlYW0tPmNtZC0+
c2VfY21kLnRyYW5zcG9ydF9zdGF0ZSB8PSBDTURfVF9BQk9SVEVEOw0KPj4gKwkJCXRhcmdldF9n
ZXRfc2Vzc19jbWQoJnN0cmVhbS0+Y21kLT5zZV9jbWQsIHRydWUpOw0KPj4gKw0KPj4gKwkJCS8q
IFRoaXMgd2lsbCB0cmlnZ2VyIGNvbW1hbmQgYWJvcnQgaGFuZGxlciAqLw0KPj4gKwkJCXRhcmdl
dF9leGVjdXRlX2NtZCgmc3RyZWFtLT5jbWQtPnNlX2NtZCk7DQo+PiArCQkJdHJhbnNwb3J0X2dl
bmVyaWNfZnJlZV9jbWQoJnN0cmVhbS0+Y21kLT5zZV9jbWQsIDEpOw0KPj4gKwkJfQ0KPj4gKw0K
Pj4gKw0KPj4gKwkJdGFyZ2V0X3N1Ym1pdF90bXJfZmFpbF9yZXNwb25zZShzZV9jbWQsIGNtZC0+
dG1yX3JzcCwNCj4+ICsJCQkJdHZfbmV4dXMtPnR2bl9zZV9zZXNzLCBjbWQtPnVucGFja2VkX2x1
biwNCj4+ICsJCQkJR0ZQX0FUT01JQywgY21kLT50YWcsIGZsYWdzKTsNCj4gSSB0aGluayB0aGVy
ZSBpcyBubyByZWFzb24gdG8gcmVqZWN0IFRNUiB2aWEgQ29yZSwgeW91IG1heSB1c2UNCj4geW91
ciB1YXNwX3NlbmRfdG1fcmVzcG9uc2UoY21kKSBkaXJlY3RseSBsaWtlIG90aGVyIGZhYnJpYyBk
cml2ZXJzIGRvZXMuDQo+IFRoYXQgd2lsbCBuZWVkIHNvbWUgY29kaW5nIHRvIGRpc3Rpbmd1aXNo
IGEgY29tcGxldGlvbiBvZiB0aGUgcmVzcG9uc2UNCj4gaW5pdGlhdGVkIGZyb20gQ29yZSBhbmQg
ZnJvbSBmYWJyaWMgZHJpdmVyLg0KDQpPay4gV2UgY2FuIGRvIHRoYXQuDQoNCj4+ICsJCXJldHVy
bjsNCj4+ICsJfQ0KPj4gKw0KPj4gKwl0YXJnZXRfc3VibWl0X3RtcihzZV9jbWQsIHR2X25leHVz
LT50dm5fc2Vfc2VzcywNCj4+ICsJCQkgIGNtZC0+cmVzcG9uc2VfaXUuYWRkX3Jlc3BvbnNlX2lu
Zm8sDQo+PiArCQkJICBjbWQtPnVucGFja2VkX2x1biwgTlVMTCwgY21kLT50bXJfZnVuYywNCj4+
ICsJCQkgIEdGUF9BVE9NSUMsIGNtZC0+dGFnLCBmbGFncyk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0
YXRpYyB2b2lkIHVzYmdfc3VibWl0X2NtZChzdHJ1Y3QgdXNiZ19jbWQgKmNtZCkNCj4+ICAgew0K
Pj4gLQlzdHJ1Y3QgdXNiZ19jbWQgKmNtZCA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgdXNi
Z19jbWQsIHdvcmspOw0KPj4gICAJc3RydWN0IHNlX2NtZCAqc2VfY21kOw0KPj4gICAJc3RydWN0
IHRjbV91c2JnX25leHVzICp0dl9uZXh1czsNCj4+ICAgCXN0cnVjdCB1c2JnX3RwZyAqdHBnOw0K
Pj4gQEAgLTEwNzMsNiArMTIyNSwxNiBAQCBzdGF0aWMgdm9pZCB1c2JnX2NtZF93b3JrKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykNCj4+ICAgCQkJVENNX1VOU1VQUE9SVEVEX1NDU0lfT1BDT0RF
LCAwKTsNCj4+ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgdm9pZCB1c2JnX2NtZF93b3JrKHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykNCj4+ICt7DQo+PiArCXN0cnVjdCB1c2JnX2NtZCAqY21kID0g
Y29udGFpbmVyX29mKHdvcmssIHN0cnVjdCB1c2JnX2NtZCwgd29yayk7DQo+PiArDQo+PiArCWlm
IChjbWQtPnRtcl9mdW5jIHx8IGNtZC0+dG1yX3JzcCAhPSBUTVJfUkVTUE9OU0VfVU5LTk9XTikN
Cj4+ICsJCXVzYmdfc3VibWl0X3RtcihjbWQpOw0KPiBUaGF0IGxvb2tzIHZlcnkgc3RyYW5nZSAt
IGluIHJlc3BvbnNlIG9mIHJlY2VpdmVkIFNDU0kgY29tbWFuZCB5b3Ugd2lsbA0KPiBzZW5kIGEg
VE1SIHJlc3BvbnNlPz8/DQo+IEkgYW0gYWJvdXQgY21kLT50bXJfcnNwICE9IFRNUl9SRVNQT05T
RV9VTktOT1dOIGNhc2UuDQoNClNvcnJ5IGlmIGl0J3MgdW5jbGVhciBoZXJlLiBUaGUgY29uZGl0
aW9uIGhlcmUgaXMgdG8gc3VibWl0IFRNUiB3aGVuIHdlIA0KaGF2ZSBhIFRBU0sgTUFOQUdFTUVO
VCBjb21tYW5kIF9vcl8gd2UgYWxyZWFkeSBrbm93IHRoYXQgd2UgbmVlZCB0byANCnN1Ym1pdCBh
IHRtcl9mYWlsX3Jlc3BvbnNlLg0KDQpUaGF0IGlzLCBhIG5vcm1hbCBjb21tYW5kIG1heSBuZWVk
IGEgVE1SIHJlc3BvbnNlIHN1Y2ggYXMgDQpUTVJfVEFTS19ET0VTX05PVF9FWElTVCBvciBUTVJf
T1ZFUkxBUFBFRF9UQUdfQVRURU1QVEVELg0KDQo+PiArCWVsc2UNCj4+ICsJCXVzYmdfc3VibWl0
X2NtZChjbWQpOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGljIHN0cnVjdCB1c2JnX2NtZCAqdXNi
Z19nZXRfY21kKHN0cnVjdCBmX3VhcyAqZnUsDQo+PiAgIAkJc3RydWN0IHRjbV91c2JnX25leHVz
ICp0dl9uZXh1cywgdTMyIHNjc2lfdGFnKQ0KPj4gICB7DQo+PiBAQCAtMTA5OSwzNyArMTI2MSw4
NCBAQCBzdGF0aWMgdm9pZCB1c2JnX3JlbGVhc2VfY21kKHN0cnVjdCBzZV9jbWQgKik7DQo+PiAg
IA0KPj4gICBzdGF0aWMgaW50IHVzYmdfc3VibWl0X2NvbW1hbmQoc3RydWN0IGZfdWFzICpmdSwg
c3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEpDQo+PiAgIHsNCj4+IC0Jc3RydWN0IGNvbW1hbmRfaXUg
KmNtZF9pdSA9IHJlcS0+YnVmOw0KPj4gKwlzdHJ1Y3QgaXUgKml1ID0gcmVxLT5idWY7DQo+PiAg
IAlzdHJ1Y3QgdXNiZ19jbWQgKmNtZDsNCj4+ICAgCXN0cnVjdCB1c2JnX3RwZyAqdHBnID0gZnUt
PnRwZzsNCj4+ICAgCXN0cnVjdCB0Y21fdXNiZ19uZXh1cyAqdHZfbmV4dXM7DQo+PiArCXN0cnVj
dCB1YXNfc3RyZWFtICpzdHJlYW07DQo+PiArCXN0cnVjdCBjb21tYW5kX2l1ICpjbWRfaXU7DQo+
PiAgIAl1MzIgY21kX2xlbjsNCj4+ICAgCXUxNiBzY3NpX3RhZzsNCj4+ICAgDQo+PiAtCWlmIChj
bWRfaXUtPml1X2lkICE9IElVX0lEX0NPTU1BTkQpIHsNCj4+IC0JCXByX2VycigiVW5zdXBwb3J0
ZWQgdHlwZSAlZFxuIiwgY21kX2l1LT5pdV9pZCk7DQo+PiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4+
IC0JfQ0KPj4gLQ0KPj4gICAJdHZfbmV4dXMgPSB0cGctPnRwZ19uZXh1czsNCj4+ICAgCWlmICgh
dHZfbmV4dXMpIHsNCj4+ICAgCQlwcl9lcnIoIk1pc3NpbmcgbmV4dXMsIGlnbm9yaW5nIGNvbW1h
bmRcbiIpOw0KPj4gICAJCXJldHVybiAtRUlOVkFMOw0KPj4gICAJfQ0KPj4gICANCj4+IC0JY21k
X2xlbiA9IChjbWRfaXUtPmxlbiAmIH4weDMpICsgMTY7DQo+PiAtCWlmIChjbWRfbGVuID4gVVNC
R19NQVhfQ01EKQ0KPj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+PiAtDQo+PiAtCXNjc2lfdGFnID0g
YmUxNl90b19jcHVwKCZjbWRfaXUtPnRhZyk7DQo+PiArCXNjc2lfdGFnID0gYmUxNl90b19jcHVw
KCZpdS0+dGFnKTsNCj4+ICAgCWNtZCA9IHVzYmdfZ2V0X2NtZChmdSwgdHZfbmV4dXMsIHNjc2lf
dGFnKTsNCj4+ICAgCWlmIChJU19FUlIoY21kKSkgew0KPj4gICAJCXByX2VycigidXNiZ19nZXRf
Y21kIGZhaWxlZFxuIik7DQo+PiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+PiAgIAl9DQo+PiAtCW1l
bWNweShjbWQtPmNtZF9idWYsIGNtZF9pdS0+Y2RiLCBjbWRfbGVuKTsNCj4+ICAgDQo+PiAtCWNt
ZC0+c3RyZWFtID0gJmZ1LT5zdHJlYW1bY21kLT50YWcgJSBVU0JHX05VTV9DTURTXTsNCj4+ICsJ
Y21kLT5yZXEgPSByZXE7DQo+PiArCWNtZC0+ZnUgPSBmdTsNCj4+ICsJY21kLT50YWcgPSBzY3Np
X3RhZzsNCj4+ICsJY21kLT5zZV9jbWQudGFnID0gc2NzaV90YWc7DQo+PiArCWNtZC0+dG1yX2Z1
bmMgPSAwOw0KPj4gKwljbWQtPnRtcl9yc3AgPSBUTVJfUkVTUE9OU0VfVU5LTk9XTjsNCj4gVE1S
XyogY29uc3RhbnQgYXJlIGZhYnJpYyBhZ25vc3RpYyBlbnVtLiBCZXR0ZXIgdXNlIFJDX1RNRl8q
IHZhbHVlcyBpbg0KPiB2YXJpYWJsZXMgb2YgdGhpcyBkcml2ZXIuDQoNClN1cmUsIHdlIGNhbiBk
byB0aGF0Lg0KDQo+PiArDQo+PiArCWNtZF9pdSA9IChzdHJ1Y3QgY29tbWFuZF9pdSAqKWl1Ow0K
Pj4gKw0KPj4gKwkvKiBDb21tYW5kIGFuZCBUYXNrIE1hbmFnZW1lbnQgSVVzIHNoYXJlIHRoZSBz
YW1lIExVTiBvZmZzZXQgKi8NCj4+ICsJY21kLT51bnBhY2tlZF9sdW4gPSBzY3NpbHVuX3RvX2lu
dCgmY21kX2l1LT5sdW4pOw0KPj4gKw0KPj4gKwlpZiAoaXUtPml1X2lkICE9IElVX0lEX0NPTU1B
TkQgJiYgaXUtPml1X2lkICE9IElVX0lEX1RBU0tfTUdNVCkgew0KPj4gKwkJY21kLT50bXJfcnNw
ID0gVE1SX1RBU0tfRE9FU19OT1RfRVhJU1Q7DQo+PiArCQlnb3RvIHNraXA7DQo+PiArCX0NCj4+
ICsNCj4+ICsJLyoNCj4+ICsJICogRm9yIHNpbXBsaWNpdHksIHdlIHVzZSBtb2Qgb3BlcmF0aW9u
IHRvIHF1aWNrbHkgZmluZCBhbiBpbi1wcm9ncmVzcw0KPj4gKwkgKiBtYXRjaGluZyBjb21tYW5k
IHRhZyBhbmQgcmVzcG9uZCB3aXRoIG92ZXJsYXBwZWQgY29tbWFuZC4gVGhlDQo+PiArCSAqIGFz
c3VtcHRpb24gaXMgdGhhdCB0aGUgVUFTUCBjbGFzcyBkcml2ZXIgd2lsbCBsaW1pdCB0byB1c2lu
ZyB0YWcgaWQNCj4+ICsJICogZnJvbSAxIHRvIFVTQkdfTlVNX0NNRFMuIFRoaXMgaXMgYmFzZWQg
b24gb2JzZXJ2YXRpb24gZnJvbSB0aGUNCj4+ICsJICogV2luZG93cyBhbmQgTGludXggVUFTUCBz
dG9yYWdlIGNsYXNzIGRyaXZlciBiZWhhdmlvci4gSWYgYW4gdW51c3VhbA0KPj4gKwkgKiBVQVNQ
IGNsYXNzIGRyaXZlciB1c2VzIGEgdGFnIGdyZWF0ZXIgdGhhbiBVU0JHX05VTV9DTURTLCB0aGVu
IHRoaXMNCj4+ICsJICogbWV0aG9kIG1heSBubyBsb25nZXIgd29yayBkdWUgdG8gcG9zc2libGUg
c3RyZWFtIGlkIGNvbGxpc2lvbi4gSW4NCj4+ICsJICogdGhhdCBjYXNlLCB3ZSBuZWVkIHRvIHVz
ZSBhIHByb3BlciBhbGdvcml0aG0gdG8gZmV0Y2ggdGhlIHN0cmVhbSAob3INCj4+ICsJICogc2lt
cGx5IHdhbGsgdGhyb3VnaCBhbGwgYWN0aXZlIHN0cmVhbXMgdG8gY2hlY2sgZm9yIG92ZXJsYXAp
Lg0KPj4gKwkgKi8NCj4+ICsJc3RyZWFtID0gdWFzcF9nZXRfc3RyZWFtX2J5X3RhZyhmdSwgc2Nz
aV90YWcpOw0KPj4gKwlpZiAoc3RyZWFtLT5jbWQpIHsNCj4+ICsJCVdBUk5fT05DRShzdHJlYW0t
PmNtZC0+dGFnICE9IHNjc2lfdGFnLA0KPiBXQVJOIGlzIHVzZWQgdG8gaW5kaWNhdGUgYSBub24g
ZmF0YWwgYnVnIGluIHRoZSBjb2RlLiBNYXkgYmUgeW91IHdhbnQgdG8NCj4gdXNlIHByX3dhcm4v
cHJfZXJyIGhlcmU/DQoNCk9rLiBXaWxsIHVwZGF0ZS4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPj4g
KwkJCSAgIkNvbW1hbmQgdGFnICVkIGNvbGxpZGVkIHdpdGggU3RyZWFtIGlkICVkXG4iLA0KPj4g
KwkJCSAgc2NzaV90YWcsIHN0cmVhbS0+Y21kLT50YWcpOw0KPj4gKw0KPj4gKwkJY21kLT50bXJf
cnNwID0gVE1SX09WRVJMQVBQRURfVEFHX0FUVEVNUFRFRDsNCj4+ICsJCWdvdG8gc2tpcDsNCj4+
ICsJfQ0KPj4gKw0KPj4gKwlzdHJlYW0tPmNtZCA9IGNtZDsNCj4+ICsNCj4+ICsJaWYgKGl1LT5p
dV9pZCA9PSBJVV9JRF9UQVNLX01HTVQpIHsNCj4+ICsJCXN0cnVjdCB0YXNrX21nbXRfaXUgKnRt
X2l1Ow0KPj4gKw0KPj4gKwkJdG1faXUgPSAoc3RydWN0IHRhc2tfbWdtdF9pdSAqKWl1Ow0KPj4g
KwkJY21kLT50bXJfZnVuYyA9IHVhc3BfdG9fdGNtX2Z1bmModG1faXUtPmZ1bmN0aW9uKTsNCj4+
ICsJCWdvdG8gc2tpcDsNCj4+ICsJfQ0KPj4gKw0KPj4gKwljbWRfbGVuID0gKGNtZF9pdS0+bGVu
ICYgfjB4MykgKyAxNjsNCj4+ICsJaWYgKGNtZF9sZW4gPiBVU0JHX01BWF9DTUQpIHsNCj4+ICsJ
CXByX2VycigiaW52YWxpZCBsZW4gJWRcbiIsIGNtZF9sZW4pOw0KPj4gKwkJdGFyZ2V0X2ZyZWVf
dGFnKHR2X25leHVzLT50dm5fc2Vfc2VzcywgJmNtZC0+c2VfY21kKTsNCj4+ICsJCXN0cmVhbS0+
Y21kID0gTlVMTDsNCj4+ICsJCXJldHVybiAtRUlOVkFMOw0KPj4gKwl9DQo+PiArCW1lbWNweShj
bWQtPmNtZF9idWYsIGNtZF9pdS0+Y2RiLCBjbWRfbGVuKTsNCj4+ICAgDQo+PiAgIAlzd2l0Y2gg
KGNtZF9pdS0+cHJpb19hdHRyICYgMHg3KSB7DQo+PiAgIAljYXNlIFVBU19IRUFEX1RBRzoNCj4+
IEBAIC0xMTUwLDkgKzEzNTksNyBAQCBzdGF0aWMgaW50IHVzYmdfc3VibWl0X2NvbW1hbmQoc3Ry
dWN0IGZfdWFzICpmdSwgc3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEpDQo+PiAgIAkJYnJlYWs7DQo+
PiAgIAl9DQo+PiAgIA0KPj4gLQljbWQtPnVucGFja2VkX2x1biA9IHNjc2lsdW5fdG9faW50KCZj
bWRfaXUtPmx1bik7DQo+PiAtCWNtZC0+cmVxID0gcmVxOw0KPj4gLQ0KPj4gK3NraXA6DQo+PiAg
IAlJTklUX1dPUksoJmNtZC0+d29yaywgdXNiZ19jbWRfd29yayk7DQo+PiAgIAlxdWV1ZV93b3Jr
KHRwZy0+d29ya3F1ZXVlLCAmY21kLT53b3JrKTsNCj4+ICAgDQo+PiBAQCAtMTI5OCwxMyArMTUw
NSwxNiBAQCBzdGF0aWMgaW50IHVzYmdfZ2V0X2NtZF9zdGF0ZShzdHJ1Y3Qgc2VfY21kICpzZV9j
bWQpDQo+PiAgIA0KPj4gICBzdGF0aWMgdm9pZCB1c2JnX3F1ZXVlX3RtX3JzcChzdHJ1Y3Qgc2Vf
Y21kICpzZV9jbWQpDQo+PiAgIHsNCj4+ICsJc3RydWN0IHVzYmdfY21kICpjbWQgPSBjb250YWlu
ZXJfb2Yoc2VfY21kLCBzdHJ1Y3QgdXNiZ19jbWQsIHNlX2NtZCk7DQo+PiArDQo+PiArCXVhc3Bf
c2VuZF90bV9yZXNwb25zZShjbWQpOw0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgdm9pZCB1
c2JnX2Fib3J0ZWRfdGFzayhzdHJ1Y3Qgc2VfY21kICpzZV9jbWQpDQo+PiAgIHsNCj4+ICAgCXN0
cnVjdCB1c2JnX2NtZCAqY21kID0gY29udGFpbmVyX29mKHNlX2NtZCwgc3RydWN0IHVzYmdfY21k
LCBzZV9jbWQpOw0KPj4gICAJc3RydWN0IGZfdWFzICpmdSA9IGNtZC0+ZnU7DQo+PiAtCXN0cnVj
dCB1YXNfc3RyZWFtICpzdHJlYW0gPSBjbWQtPnN0cmVhbTsNCj4+ICsJc3RydWN0IHVhc19zdHJl
YW0gKnN0cmVhbSA9IHVhc3BfZ2V0X3N0cmVhbV9ieV90YWcoZnUsIGNtZC0+dGFnKTsNCj4+ICAg
CWludCByZXQgPSAwOw0KPj4gICANCj4+ICAgCWlmIChzdHJlYW0tPnJlcV9vdXQtPnN0YXR1cyA9
PSAtRUlOUFJPR1JFU1MpDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0
aW9uL3RjbS5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3RjbS5oDQo+PiBpbmRleCA1
MTU3YWYxYjE2NmIuLmYxY2QyMzk5ZmQ2OSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi90Y20uaA0KPj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L3RjbS5oDQo+PiBAQCAtODIsOCArODIsMTEgQEAgc3RydWN0IHVzYmdfY21kIHsNCj4+ICAgCXUx
NiB0YWc7DQo+PiAgIAl1MTYgcHJpb19hdHRyOw0KPj4gICAJc3RydWN0IHNlbnNlX2l1IHNlbnNl
X2l1Ow0KPj4gKwlzdHJ1Y3QgcmVzcG9uc2VfaXUgcmVzcG9uc2VfaXU7DQo+PiAgIAllbnVtIHVh
c19zdGF0ZSBzdGF0ZTsNCj4+IC0Jc3RydWN0IHVhc19zdHJlYW0gKnN0cmVhbTsNCj4+ICsJaW50
IHRtcl9mdW5jOw0KPj4gKwlpbnQgdG1yX3JzcDsNCj4+ICsjZGVmaW5lCVRNUl9SRVNQT05TRV9V
TktOT1dOIDB4ZmYNCj4+ICAgDQo+PiAgIAkvKiBCT1Qgb25seSAqLw0KPj4gICAJX19sZTMyIGJv
dF90YWc7DQo+PiBAQCAtOTYsNiArOTksOCBAQCBzdHJ1Y3QgdWFzX3N0cmVhbSB7DQo+PiAgIAlz
dHJ1Y3QgdXNiX3JlcXVlc3QJKnJlcV9pbjsNCj4+ICAgCXN0cnVjdCB1c2JfcmVxdWVzdAkqcmVx
X291dDsNCj4+ICAgCXN0cnVjdCB1c2JfcmVxdWVzdAkqcmVxX3N0YXR1czsNCj4+ICsNCj4+ICsJ
c3RydWN0IHVzYmdfY21kCQkqY21kOw0KPj4gICB9Ow0KPj4gICANCj4+ICAgc3RydWN0IHVzYmdf
Y2RiIHsNCg0K
