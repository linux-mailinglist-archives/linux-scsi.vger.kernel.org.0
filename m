Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A608664F289
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Dec 2022 21:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiLPUoi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 16 Dec 2022 15:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiLPUog (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 16 Dec 2022 15:44:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713E26D1;
        Fri, 16 Dec 2022 12:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671223471; x=1702759471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0eJouB/JpaHE1wBBtpnzKXut9n6EPmNn62vTLloHrP0=;
  b=qirykaIJzkKUAbsGhnqZ10mhsZcy6G3QMuyv3g4AWW/6kJTsqS4DTl+B
   +BPddMsItfo6MzHQbvJPntIFyBJP9/avfshH7W3YvLJbTfpX7Fc0eP0c5
   VtXTwz+3gxjDmoK7qKZn43mi+F3vZrk2yeuGBiAWHeO8Nx9AfJbE4Wy2X
   cOWhQU6Cj8xh5S6O4nZcqWCbociVWQYNbUCsjnplFRzJDL7jfOeaETojP
   beOe3qelyg1jBGZf7yQTD/yU3+2ic/V1flairA40l5QOaUVqLAkOFRDci
   b5npRfPtLq97vKC4D5FCoa4ORB5EJf2ihrTRC5SvvIbhLVz2IFzcfdk5Y
   w==;
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="193403106"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2022 13:44:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 13:44:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 13:44:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrIaTQVs/1rvtF9Dx5gkGf1tmHGBGdcEGFHl3yraIDvd1Qf9yK6kxgFLXexryOebkwXymjqKuH2Zkv5fgyTJY8FBeCFEDV4qvm9HI0bSPDHqoCmlul7T6O+uIxeVjMQxyWbMD1bRJ1H+8KSsOeSe3G+9LMrGQ4646RxQYFHHwordTDxR8kQ7UfaaeIg9wEBslSqrekipId5KFuBm/l1vb0ncB4SmseXC4t1/vMsGoNXqDaKMXtLEIvZONJk4b5RmKVx7QZu2UM59WZhesJNk4vbwCx8wW9Uvcbk7G5V5z7J6Bz1HMll170ZrAVVDRYmXrpo3L+GyoaR30OiAcTux6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eJouB/JpaHE1wBBtpnzKXut9n6EPmNn62vTLloHrP0=;
 b=e/MOpm5zM3hmoC75O4Svgr0Rt5l2u0lU4r8e9olZM102HeyYQMzcMv6CL9sArjU79jy1+1dFZDGLRPK0AKuZwtEZXZRz8g4+9STddWAbi/O976jWX+HI1OpN/7tA9HEYGFm8kJ1+lEZfbdpsNbD7nxzcJC7q+9qJ6UnMC5iduW8vNq8cPyoDlEgbg8goYganuMj0CL+7zkMA0l1rcrUvDfHvTjJa8Z/2Ys6QgFnbq3b/iV137WBDlYX+ETJ7z9McfGUnB+4XVb9sXKBzpIB+d6bQJFnrR/UgT+nlEMrjbD3a9x7EZqtRmi3n4r/0rNIg0NKgBHPx+neGGX8Md6fgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eJouB/JpaHE1wBBtpnzKXut9n6EPmNn62vTLloHrP0=;
 b=b65vZpe4Qs6cWcWo6u7Cqq1QCW/bEOz4zKz+KgsH4oGtqiPPCkjk7qz5gdHDDVeUIJprjxHMzWMXREpABSBAEQrEutBEhygjo6aQyALsJr4WgHhLsIaSQmsowAl+M+g6+eu/liowUeQWOIn2U5rQQZ8cqTOzgNbp70WgG+21Mug=
Received: from BYAPR11MB3606.namprd11.prod.outlook.com (2603:10b6:a03:b5::25)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 20:44:23 +0000
Received: from BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::29ed:b573:91d9:2288]) by BYAPR11MB3606.namprd11.prod.outlook.com
 ([fe80::29ed:b573:91d9:2288%3]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 20:44:23 +0000
From:   <Sagar.Biradar@microchip.com>
To:     <Sagar.Biradar@microchip.com>, <james.hilliard1@gmail.com>
CC:     <martin.petersen@oracle.com>, <khorenko@virtuozzo.com>,
        <christian@grossegger.com>, <aacraid@microsemi.com>,
        <Don.Brace@microchip.com>, <Tom.White@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Gilbert.Wu@microchip.com>
Subject: RE: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
Thread-Topic: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
Thread-Index: AQHXQsZcat53f5Y0GUewzbFQW8Fr6KygDOeAgAIrQgeBaIqnAIAOgRQAgAskdwCAAV8v8IAa0mqAgALSqOCAAhorgIAB8LcQgBjoggCAA4m+8IAQpmQA
Date:   Fri, 16 Dec 2022 20:44:22 +0000
Message-ID: <BYAPR11MB3606E15393A4C11CCFAF9C53FAE69@BYAPR11MB3606.namprd11.prod.outlook.com>
References: <yq15zo86nvk.fsf@oracle.com>
 <20190819163546.915-1-khorenko@virtuozzo.com>
 <CADvTj4rVS-wJy1B=dgEO1AOADNYgL3XkZ01Aq=RTfPGEZC+VMA@mail.gmail.com>
 <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com>
 <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
 <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com>
 <106f384f-d9e2-905d-5ac5-fe4ffd962122@virtuozzo.com>
 <CADvTj4rd+Z8S8vwnsmn2a7BXDPBwx1iqWRmE+SbtWep=Lnr20g@mail.gmail.com>
 <BYAPR11MB36066925274C38555F20FB17FA339@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4qH5xuK9ecEPi3Pm9t962E=nnH0oTBqWv4UPmibeASqdQ@mail.gmail.com>
 <BYAPR11MB36065EE0321C0AE6A4A3ECC7FA049@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4oej_E3tHm6tzOAhA=n2WughvDfQsaxKbP5Sxb+CeZu=w@mail.gmail.com>
 <BYAPR11MB360625E5945D5D3B29571857FA099@BYAPR11MB3606.namprd11.prod.outlook.com>
 <CADvTj4oNCrwHBRu-rUZtnxoqVkvyxG_Cg07RTAuwpNsGfjWKcw@mail.gmail.com>
 <BYAPR11MB3606FB1E651EC9B51BD8A0B7FA1B9@BYAPR11MB3606.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3606FB1E651EC9B51BD8A0B7FA1B9@BYAPR11MB3606.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3606:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: 911f04a1-8306-4fb7-8579-08dadfa65038
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mE30iIeAMumXGTl7agSjoJMNkNHmG4JgZABr86xpuSJMEMr7Vf/hvRR123So36JBhKqvmJWwvLxCgSne0PT6wXRiTVMOx4UadYfkmiZ7Vf+3nZmJ5I42hU2w5ws6kcqH6Gb5WKToBzPWR6hB3r9INq6r3poJ8CvGh5bMQcW7V5K+FpPIyTQeOgIjxphvY/jn3k1n8ZtRqEPADcl2oh2agjw+l00lMxbs5TCt8kD3RJ/d4ZikMBvNZOJDt0WyL4imMVc9FVmpQvfdlpX/J+30sPdWHQ+BMso+YcA2gyt+pnpMKUxQqcY/qprbgbW7kL9oYVwM89at6O5sUIi5jiszr/BkWecjYPRFpUtbfFDoBigyZGCyeUNZzkMgNK7ZSrY64X87cPgGVF4Q5BuQy5FTiXmvHq+w0gGObjrIt3M1A3MxXBkXW6y6Y6UrSZ7eVPuNSDnyxRGeZoUOMnNPXyDkKzrNtimlmdPEAPt5XPSJuib0ADmtw0TyVvdXrHYx3emw9BpttAZepzJ9jsObrVFR1V3W5FFmaoVCgDUQ+LWlKvM8Kne6GcMcok1Gq2OKdGJCoqRnt5wk06oP06trdNuYv8y4sPBkfT+C/7GPmEhdLU7NVEerbGGXQCl3uxp7+4rTDXuJ6SjYsV0yptnLXr+4RiuX0FKh+sV2fdb6bL0MfokIzoQAyQwTP5CFS9ZMvO4G35JZ0KhQNQDqVC2X6fbYOpY/BPRdfoyWouL3yIN3vBloZtpocrUOkxFExS4OZLBpXdpXCrObUFK2dACtlofWHNfZI6N2fQMmT9vRMQuubFCwqAw/EfUGrBoDvvJ5Scmx5TjHx2nORCUl8EbgwoqrSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3606.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(30864003)(2906002)(33656002)(5660300002)(38070700005)(6506007)(7696005)(53546011)(86362001)(26005)(83380400001)(66574015)(107886003)(186003)(45080400002)(9686003)(966005)(71200400001)(478600001)(55016003)(110136005)(64756008)(54906003)(4326008)(8936002)(66556008)(66476007)(76116006)(66946007)(52536014)(8676002)(316002)(66446008)(41300700001)(38100700002)(122000001)(414714003)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnFuNDhTZS9Ob1lzd2NSUGpWR0toVndReEU3eWJORDQ2OXhIVUpvajN5Yy81?=
 =?utf-8?B?eDNrNkdaWkxhRTFrQzZnMWhDWEZXM3dEVUdGc29yclRKTmZCQzNnSTRqMWpP?=
 =?utf-8?B?NWNTdStBS1dLblVGNmJqOVdJdEJQRkdQTWJkOEtDMHVaL0NabVFKY3lDdEFr?=
 =?utf-8?B?MVdURnNxOTJCRHZ3bXhZYzhTZEZ5QTh2TzNabE1LQUkyZHFwaE5CV2F5WGdM?=
 =?utf-8?B?MTN5d1Q4K2NKb2FZNmtmbUpRODdCR21za2pUVzI5VERvRXpSQk1uM0x6ZC94?=
 =?utf-8?B?L1Q5Mkt2Z3RLTDNBd2tuNUdKaGEwK3VPTXd6bDRpOFVWcjVFdjdZYTIvaVd0?=
 =?utf-8?B?cjNMUWFxV2ljZDI5RFNNVEJXU09NWEUzUStRdS9EOUwrcXk3bWsyUmovakMr?=
 =?utf-8?B?Z25sRUNLRTJwNVFpTlFxYU9uNFNDRFJzR0d3aEw3R0xRcTFEeVlodkdLc2lx?=
 =?utf-8?B?aEMrOVVBVms5cklPQWpqT1Bnc3RhemxORUJZZi8wbDFvMUl3T1JXY3BiU08z?=
 =?utf-8?B?Y2pjNHVscjdTM0JyWE0yMklFbDBOOEI4M1ppamJ5bTJqVk5vMzYrZUtRMW1i?=
 =?utf-8?B?N2VId0NkSXM4ZjRmY09Deng1dmRzSGhpdG9IQi8yNkx1Vlh3S01YYWM2MCtX?=
 =?utf-8?B?RHlpbEhjdFVjbk9BQjI0VUdRZkFRbDlLaDVGVmpQR2tkaWYzMjViTCtpT01X?=
 =?utf-8?B?TUN6aHllVFY2L1laWDM5RTB2UWFEQndkVXpPWkdDOXlGdTNXUDdNODIwcEx3?=
 =?utf-8?B?YkpFVmFnYThzc0pBK2U2TVc3ZTM1NTl5czNralV2RWVLQXo3VXc3bVlBbFg1?=
 =?utf-8?B?ZTJPcy9kMDFhbXBDWUYxSE1GdjZiVkh5dkFqYlVJditJU2NGdlVqQUlQNm9z?=
 =?utf-8?B?c3YrMkJ2THhEM2hiT0QxZGE4OFViWmJDalJicGg3SGJXTnY3cU9VbGpuZFFn?=
 =?utf-8?B?aGJaYWtGN1VURWdOd1YyNE1EZUNHZTB5OEkwMWQ0ZXJqck9ROE1QM1pFdWp3?=
 =?utf-8?B?RVBUQ1kySy9XSjhiS1hSUDN4Ty9LY0p2Y1l2bGpSRmFPUkpTL2xpOWZ3Mnlp?=
 =?utf-8?B?c3g0UVNNbnRXQkdUVDBVbHgwRG5CM21ZUGswZGp3Vy8yLzRycm5BbEdsOEI4?=
 =?utf-8?B?QWErV2xqdmw2NnMrOE1MOW1TZjc5Ym0rTUxjWFp3RXlaaEhYOU9PWTFBcjNm?=
 =?utf-8?B?MGlYc1JvamRUNzRveElRSU8rRW5uZ25qWS9VWi96UEVjQzdjeUhZbUFwZHhP?=
 =?utf-8?B?K29nZHFBVkRHeC84RVgveTROajgwY2xISmtNVUdIYXpUQjVNVzVaM0N0aDBZ?=
 =?utf-8?B?QjFDdWNNeG51Z3V3NmhseHBoWFVxUmVrbk5aT0lkdHNSMFpzRThncTdsS2Z5?=
 =?utf-8?B?MFllM3dja3RjYzJ4VFI5cDJjczhid1RBRm4wT05HZHFUSW9qZmVGUVNuY2lz?=
 =?utf-8?B?U0xvYWRiSk5zMVFadXl6a1Q0eFJ5QzZ1OFlGdkRVQ245R205V2tyR0JielR5?=
 =?utf-8?B?cU16Y1hwaWsvcmRmMGZoRWgxbXJqZDZyN0s5Ymx4NG53NkRKQWFwa25DMkEy?=
 =?utf-8?B?Qk9wUzF6QVk4NnEyOHhtWU5RZ0dVaWp0Z0d0RlNvSjJTVFZGK3VnYi9mRzJl?=
 =?utf-8?B?MlVpTHAweFlUWHhScmZnOGJxbnIvQXhLYVZrdDVJQmVaMm8vZ1JEaWxtUC9X?=
 =?utf-8?B?UWl2M1R0Nm91ZzQ3U0Z6VGhReEZiOXN4RzRGc0psYjUzOGRSdm9yTWpaN2dW?=
 =?utf-8?B?SVBNMmpHNTlxZ2pqMUxwK1hXekJXVGlxdFhWYzNaclNaRUhLdUk1Yi9TY1V0?=
 =?utf-8?B?RmkyNWpuSnFXVXdJNUhSYmxqYzdPQ21tQXd1a2JtZWI2NXcvV0N0Y214ZlFo?=
 =?utf-8?B?ZlVwbDNiakNtcEMzZDNuS0toOHJLeFk2L1ZEWVFTd1FpZWVLRnlHM2xycUkr?=
 =?utf-8?B?Z2pEbkJVWXFQU2FreVBuYytXZXlsaUswQm9CS0JtQUlnU3Nobm1wU2VKUEFH?=
 =?utf-8?B?S3IwdnRxU3pDTGZmaUxWeXBzb2l6L3NnNzE3OUNBNzNlVnE3c0x0aHB2Z0cr?=
 =?utf-8?B?T3c3UnM3NXhPajNOdm1aTHY4ck9yRW5mb3VvRWVhbUZEMEpaUjAybmpjUzhJ?=
 =?utf-8?B?SlFUQkJyUzNwL1hhd0M3ck9Dd2hDNVFJL3g4di9TcHgySG5QQkpSSmd5Z1lR?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3606.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911f04a1-8306-4fb7-8579-08dadfa65038
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 20:44:22.9011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qYUUtRxorf77uJcPKhdOgYRMpoLVFnFJlkU2mmAhjRZ21Dx/hvuo4BZQ3buiLspVDK5qvvrWbiNHBYaD7gc6cYDm5zDTuwv5N9ciNWnL+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

SGkgSmFtZXMgLyBLb25zdGFudGluLA0KSGVyZSBhcmUgdGhlIGRldGFpbHMgdGhhdCB3ZSBoYXZl
IGNvbXBpbGVkIHNvIGZhciAuIC4gDQpJIHdpbGwganVzdCByZXBvc3QgdGhlIHByb2JsZW0gZGVm
aW5pdGlvbiBhbmQgdGhlIGNvbmNlcm5zIGRpc2N1c3NlZCBzbyBmYXIgKHRvIGF2b2lkIGJhY2sg
YW5kIGZvcnRoKS4uLg0KDQpJc3N1ZSA6IFNlcmllcyA2IFBhdGNoIFtyZWdyZXNzaW9uXSBhYWNy
YWlkOiBIb3N0IGFkYXB0ZXIgY29uc3RhbnRseSBhYm9ydHMgdW5kZXIgbG9hZCAoaHR0cHM6Ly9i
dWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNzI0MDc3KQ0KDQpTeW5vcHNpczog
cnVubmluZyBta2ZzLmV4dDQgb24gZGlmZmVyZW50IGRpc2tzIG9uIHRoZSBzYW1lIGNvbnRyb2xs
ZXIgaW4gcGFyYWxsZWwuIChOb3RoaW5nIHNlZW1zIHRvIGJyZWFrLCBhcHBlYXJzIHRvIGFsd2F5
cyByZWNvdmVyLCBidXQgdGhlcmUgYXJlIGEgbG90IG9mIHRpbWVvdXRzLikNClsgIDY5OS40NDI5
NTBdIGFhY3JhaWQ6IEhvc3QgYWRhcHRlciByZXNldCByZXF1ZXN0LiBTQ1NJIGhhbmcgPw0KWyAg
NzU5LjUxNTAxM10gYWFjcmFpZCAwMDAwOjAzOjAwLjA6IElzc3VpbmcgSU9QIHJlc2V0DQpbICA4
NTAuMjk2NzA1XSBhYWNyYWlkIDAwMDA6MDM6MDAuMDogSU9QIHJlc2V0IHN1Y2NlZWRlZA0KKiB3
aXRoIGtlcm5lbCAzLjEwLjAtODYyLjIwLjIuZWw3Lng4Nl82NCAtIFBBU1MNCiogd2l0aCBrZXJu
ZWwgMy4xMC4wLTk1Ny4yMS4zLmVsNy54ODZfNjQgLSBGQUlMDQoNCktvbnN0YW50aW7igJlzIHBh
dGNoIChodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS84LzE5Lzc1OCkgOiB1cG9uIHRlc3Rpbmcg
dGhlIHBhdGNoIG9uIHRoZSBWaXJ0dW96em8ga2VybmVsLCBpdCB3YXMgZm91bmQgdG8gYmUgd29y
a2luZyBmaW5lLCBhbmQgdGhlIHNhbWUgaXNzdWUgd2FzIG9ic2VydmVkIG9uIFVidW50dSBsYXRl
ci4NCkJ1dCBNQ0hQIGtub3dzIHRoaXMgcGF0Y2gvY2hhbmdlIHdpbGwgaGF2ZSBpc3N1ZXMgd2l0
aCBYZW9uIFYyIGludGVycnVwdHMsIGFkZGluZyB0aGlzIGNoYW5nZSBpbnRvIHRoZSB0cmVlIGNh
biBoYXJtIHRoZSBjdXN0b21lcnMgd2hvIHVzZSB0aGlzIHByb2Nlc3Nvci4gKENQVSBJbnRlbCBY
ZW9uIEU1LTI2MDkvMjYzMC8yNjUwIHYyICggRTUtMjZYWCBWMikpDQpIb3dldmVyLCB0aGUgcGF0
Y2ggbWF5IHdvcmsgZmluZSBvbiBYZW9uIFYzL1Y0IGFuZCBsYXRlciBwcm9jZXNzb3JzLg0KDQpB
ZGFwdGVjIEFTSyBBcnRpY2xlIHJlZmVyZW5jZXMgb3VyIGNvbmNlcm4gOiBodHRwczovL2Fzay5h
ZGFwdGVjLmNvbS9hcHAvYW5zd2Vycy9kZXRhaWwvYV9pZC8xNzQwMC9rdy9tc2kNClRob3VnaCB0
aGUgYXJ0aWNsZSBsaXN0cyBhcHBlYXJzIGxpa2UgYSAiVk13YXJlIiBzcGVjaWZpYyAtIHRoZSBp
c3N1ZSBpcyBpbmRlcGVuZGVudCBvZiB0aGUgT3BlcmF0aW5nIHN5c3RlbS4NCldlIGhhdmUgZGlz
Y292ZXJlZCBhIGNvbmZsaWN0IGJldHdlZW4gdGhlIFNlcmllcyA2IGFuZCA2RSBSQUlEIGNvbnRy
b2xsZXJzLCBWTXdhcmUgRVNYaSA1LjUgYW5kIEludGVsIFhlb24gVjIgcHJvY2Vzc29ycyB0aGF0
IGlzIGNhdXNlZCBieSBpbmNvcnJlY3QgaW50ZXJydXB0IGhhbmRsaW5nLiANClRoZSBzeXN0ZW0g
aXMgdXNpbmcgdGhlIGxlZ2FjeSBpbnRlcnJ1cHQgaGFuZGxpbmcgYnV0IG5lZWRzIHRvIGJlIHN3
aXRjaGVkIHRvIE1TSSAoTWVzc2FnZSBTaWduYWxlZCBJbnRlcnJ1cHRzKSBpbnN0ZWFkLg0KVGhp
cyBpc3N1ZSBjYXVzZWQgYnkgc3dpdGNoaW5nIHRvIHRoZSBsZWdhY3kgbW9kZSBvY2N1cnMgb24g
Q1BVIEludGVsIFhlb24gRTUtMjYwOS8yNjMwLzI2NTAgdjIgKCBFNS0yNlhYIFYyKS4NCiogTm90
ZTogWGVvbiBWMiBpcyDigJxJdnkgQnJpZGdl4oCdDQoNCldvcmthcm91bmQ6IFRoZSBwcm9wb3Nl
ZCBzb2x1dGlvbiB3b3VsZCBiZSB0byBsZXQgdGhlIGRyaXZlciB1c2UgdGhlIE1TSSBtZWNoYW5p
c20gd2l0aCB0aGUgYWFjcmFpZCBkcml2ZXIgcGFyYW1ldGVyICJtc2kiIHNldCB0byAxICjigJxt
c2k9MSIpIC4gICgiZWNobyAxID4gL3N5cy9tb2R1bGUvYWFjcmFpZC9wYXJhbWV0ZXJzL21zaSIp
DQoNCktvbnN0YW50aW4sDQpJcyBpdCBwb3NzaWJsZSBmb3IgeW91IG9yIHNvbWVvbmUgeW91IGtu
b3cgdG8gdGVzdCBvbiB5b3VyIG9yaWdpbmFsIHRlc3QgYmVkIHdpdGggdGhlICJtc2kiIHNldCB0
byAiMSIsIGFuZCBwb3N0IHRoZSByZXN1bHRzPw0KV2UgYXJlIHBhcmFsbGVsbHkgd29ya2luZyBv
biBhZGRpdGlvbmFsIHRlc3RzIGxvY2FsbHkuDQpQbGVhc2Ugd3JpdGUgdG8gbWUgaWYgeW91IG5l
ZWQgbW9yZSBpbmZvcm1hdGlvbg0KDQoNClRoYW5rcyBpbiBhZHZhbmNlDQpTYWdhcg0KDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTYWdhci5CaXJhZGFyQG1pY3JvY2hpcC5j
b20gPFNhZ2FyLkJpcmFkYXJAbWljcm9jaGlwLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBEZWNlbWJl
ciA2LCAyMDIyIDExOjMwIEFNDQpUbzogamFtZXMuaGlsbGlhcmQxQGdtYWlsLmNvbQ0KQ2M6IG1h
cnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBraG9yZW5rb0B2aXJ0dW96em8uY29tOyBjaHJpc3Rp
YW5AZ3Jvc3NlZ2dlci5jb207IGFhY3JhaWRAbWljcm9zZW1pLmNvbTsgRG9uIEJyYWNlIC0gQzMz
NzA2IDxEb24uQnJhY2VAbWljcm9jaGlwLmNvbT47IFRvbSBXaGl0ZSAtIEMzMzUwMyA8VG9tLldo
aXRlQG1pY3JvY2hpcC5jb20+OyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUkU6IFtQQVRDSCB2MyAwLzFdIGFhY3JhaWQ6
IEhvc3QgYWRhcHRlciBBZGFwdGVjIDY0MDUgY29uc3RhbnRseSByZXNldHMgdW5kZXIgaGlnaCBp
byBsb2FkDQoNCkVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KDQpIaSBKYW1lcywN
CldlIHdlcmUgaW4gdGhlIHByb2Nlc3Mgb2YgZmluZGluZyB0aGUgcmVsYXRlZCBpbmZvcm1hdGlv
biBhbmQgd2UgaGF2ZSBmaW5hbGx5IGZvdW5kIHNvbWUgZGV0YWlscy4NCkkgYW0gcmV2aWV3aW5n
IHRoYXQgYXMgSSB3cml0ZSB0aGlzIGVtYWlsLg0KSSB3aWxsIGdldCBiYWNrIHRvIHlvdSBvbmNl
IEkgcmV2aWV3IGFuZCBzb3J0IHRoYXQgaW5mb3JtYXRpb24gd2l0aCBtb3JlIGRldGFpbHMuDQoN
ClRoYW5rcw0KU2FnYXINCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphbWVz
IEhpbGxpYXJkIDxqYW1lcy5oaWxsaWFyZDFAZ21haWwuY29tPg0KU2VudDogU3VuZGF5LCBEZWNl
bWJlciA0LCAyMDIyIDU6MjYgQU0NClRvOiBTYWdhciBCaXJhZGFyIC0gQzM0MjQ5IDxTYWdhci5C
aXJhZGFyQG1pY3JvY2hpcC5jb20+DQpDYzogbWFydGluLnBldGVyc2VuQG9yYWNsZS5jb207IGto
b3JlbmtvQHZpcnR1b3p6by5jb207IGNocmlzdGlhbkBncm9zc2VnZ2VyLmNvbTsgYWFjcmFpZEBt
aWNyb3NlbWkuY29tOyBEb24gQnJhY2UgLSBDMzM3MDYgPERvbi5CcmFjZUBtaWNyb2NoaXAuY29t
PjsgVG9tIFdoaXRlIC0gQzMzNTAzIDxUb20uV2hpdGVAbWljcm9jaGlwLmNvbT47IGxpbnV4LXNj
c2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDAvMV0gYWFjcmFpZDogSG9zdCBhZGFwdGVyIEFkYXB0ZWMgNjQwNSBj
b25zdGFudGx5IHJlc2V0cyB1bmRlciBoaWdoIGlvIGxvYWQNCg0KRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQoNCk9uIFRodSwgTm92IDE3LCAyMDIyIGF0IDExOjM2IFBNIDxTYWdh
ci5CaXJhZGFyQG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPg0KPiBIaSBKYW1lcywNCj4gVGhhbmtz
IGZvciB5b3VyIHJlc3BvbnNlLg0KPiBUaGlzIGlzc3VlIHNlZW1zIHRvIGJlIHNsaWdodGx5IGRp
ZmZlcmVudCBhbmQgbWF5IGhhdmUgYmVlbiBvcmlnaW5hdGluZyBmcm9tIHRoZSBkcml2ZSBpdHNl
bGYgKG5vdCB0b28gc3VyZSkuDQoNClllYWgsIHRoZSBkcml2ZSB3YXMgaGF2aW5nIGhhcmR3YXJl
IGlzc3VlcywgYWx0aG91Z2ggaXQgZG9lcyBzb3VuZCBsaWtlIGEgcG90ZW50aWFsIGVycm9yIGNv
bmRpdGlvbiB0aGF0J3Mgbm90IGJlaW5nIGNvcnJlY3RseSBoYW5kbGVkIGJ5IGFhY3JhaWQuDQoN
Cj4NCj4gVGhlIG9yaWdpbmFsIGlzc3VlIEkgd2FzIHRhbGtpbmcgYWJvdXQgd291bGQgc3RpbGwg
b2NjdXIgd2l0aCB0aGUgbWlzc2luZyBsZWdhY3kgaW50ZXJydXB0IG9uIGNlcnRhaW4gcHJvY2Vz
c29ycy4NCj4gV2UgYXJlIHN0aWxsIGFjdGl2ZWx5IGxvb2tpbmcgaW50byB0aGUgb2xkICJpbnQt
eCBtaXNzaW5nIiBpc3N1ZSB0aGF0IHdlIHN1c3BlY3QgbWlnaHQgcG9zc2libHkgb3JpZ2luYXRl
IGZyb20gdGhlIHBhdGNoLg0KDQpIbW0sIGFyZSB0aGVyZSBhbnkgYXZhaWxhYmxlIGRldGFpbHMg
b24gdGhpcyAiaW50LXggbWlzc2luZyIgaXNzdWUsIEkgY291bGRuJ3QgZmluZCBhbnkgcHVibGlj
IGRldGFpbHMvcmVwb3J0cyByZWxhdGluZyB0byB0aGF0Lg0KDQpJcyB0aGVyZSBhIGxpc3Qgb2Yg
Q1BVJ3Mga25vd24gdG8gYmUgYWZmZWN0ZWQ/DQoNCkRvZXMgaXQgb2NjdXIgaW4gdGhlIHZlbmRv
ciBhYWNyYWlkIHJlbGVhc2UgdGhhdCBoYXMgdGhpcyBwYXRjaCBtZXJnZWQ/DQoNCj4NCj4NCj4N
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgSGlsbGlhcmQgPGph
bWVzLmhpbGxpYXJkMUBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNywg
MjAyMiAzOjI2IEFNDQo+IFRvOiBTYWdhciBCaXJhZGFyIC0gQzM0MjQ5IDxTYWdhci5CaXJhZGFy
QG1pY3JvY2hpcC5jb20+DQo+IENjOiBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbTsga2hvcmVu
a29AdmlydHVvenpvLmNvbTsgDQo+IGNocmlzdGlhbkBncm9zc2VnZ2VyLmNvbTsgYWFjcmFpZEBt
aWNyb3NlbWkuY29tOyBEb24gQnJhY2UgLSBDMzM3MDYgDQo+IDxEb24uQnJhY2VAbWljcm9jaGlw
LmNvbT47IFRvbSBXaGl0ZSAtIEMzMzUwMyANCj4gPFRvbS5XaGl0ZUBtaWNyb2NoaXAuY29tPjsg
bGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7IA0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC8xXSBhYWNyYWlkOiBIb3N0IGFkYXB0ZXIg
QWRhcHRlYyA2NDA1IA0KPiBjb25zdGFudGx5IHJlc2V0cyB1bmRlciBoaWdoIGlvIGxvYWQNCj4N
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyANCj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiBUdWUsIE5v
diAxNSwgMjAyMiBhdCAxMDowNSBBTSA8U2FnYXIuQmlyYWRhckBtaWNyb2NoaXAuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEhpIEphbWVzLA0KPiA+IEkgaGF2ZSBsb29rZWQgaW50byB0aGUgcGF0Y2gg
dGhvcm91Z2hseS4NCj4gPiBXZSBzdXNwZWN0IHRoaXMgY2hhbmdlIG1pZ2h0IGV4cG9zZSBhbiBv
bGQgbGVnYWN5IGludGVycnVwdCBpc3N1ZSBvbiBzb21lIHByb2Nlc3NvcnMuDQo+DQo+IEkgZGlk
IHNlZSB0aGlzIGVycm9yIG9uY2Ugd2l0aCB0aGlzIHBhdGNoIHdoZW4gYSBkcml2ZSB3YXMgaGF2
aW5nIGlzc3VlczoNCj4gWyA0MzA2LjM1NzUzMV0gYWFjcmFpZDogSG9zdCBhZGFwdGVyIGFib3J0
IHJlcXVlc3QuDQo+ICAgICAgICAgICAgICAgIGFhY3JhaWQ6IE91dHN0YW5kaW5nIGNvbW1hbmRz
IG9uICgwLDEsNDEsMCk6DQo+IFsgNDMzNS4wMzAwMjVdIGFhY3JhaWQ6IEhvc3QgYWRhcHRlciBh
Ym9ydCByZXF1ZXN0Lg0KPiAgICAgICAgICAgICAgICBhYWNyYWlkOiBPdXRzdGFuZGluZyBjb21t
YW5kcyBvbiAoMCwxLDQxLDApOg0KPiBbIDQzMzUuMDMwMTExXSBhYWNyYWlkOiBIb3N0IGFkYXB0
ZXIgYWJvcnQgcmVxdWVzdC4NCj4gICAgICAgICAgICAgICAgYWFjcmFpZDogT3V0c3RhbmRpbmcg
Y29tbWFuZHMgb24gKDAsMSw0MSwwKToNCj4gWyA0MzM1LjAzMDE3Ml0gYWFjcmFpZDogSG9zdCBh
ZGFwdGVyIGFib3J0IHJlcXVlc3QuDQo+ICAgICAgICAgICAgICAgIGFhY3JhaWQ6IE91dHN0YW5k
aW5nIGNvbW1hbmRzIG9uICgwLDEsNDEsMCk6DQo+IFsgNDMzNS4xODk4ODZdIGFhY3JhaWQ6IEhv
c3QgYnVzIHJlc2V0IHJlcXVlc3QuIFNDU0kgaGFuZyA/DQo+IFsgNDMzNS4xODk5NTFdIGFhY3Jh
aWQgMDAwMDo4MTowMC4wOiBvdXRzdGFuZGluZyBjbWQ6IG1pZGxldmVsLTAgWyA0MzM1LjE4OTk4
OV0gYWFjcmFpZCAwMDAwOjgxOjAwLjA6IG91dHN0YW5kaW5nIGNtZDogbG93bGV2ZWwtMCBbIDQz
MzUuMTkwMTAxXSBhYWNyYWlkIDAwMDA6ODE6MDAuMDogb3V0c3RhbmRpbmcgY21kOiBlcnJvciBo
YW5kbGVyLTMgWyA0MzM1LjE5MDE0MV0gYWFjcmFpZCAwMDAwOjgxOjAwLjA6IG91dHN0YW5kaW5n
IGNtZDogZmlybXdhcmUtMCBbIDQzMzUuMTkwMTc3XSBhYWNyYWlkIDAwMDA6ODE6MDAuMDogb3V0
c3RhbmRpbmcgY21kOiBrZXJuZWwtMCBbIDQzMzUuMjc0MDcwXSBhYWNyYWlkIDAwMDA6ODE6MDAu
MDogQ29udHJvbGxlciByZXNldCB0eXBlIGlzIDMgWyA0MzM1LjI3NDE0Ml0gYWFjcmFpZCAwMDAw
OjgxOjAwLjA6IElzc3VpbmcgSU9QIHJlc2V0IFsgNDM2NS44NjIxMjddIGFhY3JhaWQgMDAwMDo4
MTowMC4wOiBJT1AgcmVzZXQgc3VjY2VlZGVkIFsgNDM2NS44OTUwNzldIGFhY3JhaWQ6IENvbW0g
SW50ZXJmYWNlIHR5cGUyIGVuYWJsZWQgWyA0Mzc0LjkzODExOV0gYWFjcmFpZCAwMDAwOjgxOjAw
LjA6IFNjaGVkdWxpbmcgYnVzIHJlc2NhbiBbIDQzODcuMDIyOTEzXSBzZCAwOjE6NDE6MDogW3Nk
aV0gMjczNDQ3NjQ5MjggNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6DQo+ICgxNC4wIFRCLzEyLjcg
VGlCKQ0KPiBbIDQzODcuMDIyOTg4XSBzZCAwOjE6NDE6MDogW3NkaV0gNDA5Ni1ieXRlIHBoeXNp
Y2FsIGJsb2NrcyBbIDU2NDMuNzE0MzAxXSBhYWNyYWlkOiBIb3N0IGFkYXB0ZXIgYWJvcnQgcmVx
dWVzdC4NCj4gICAgICAgICAgICAgICAgYWFjcmFpZDogT3V0c3RhbmRpbmcgY29tbWFuZHMgb24g
KDAsMSw0MSwwKToNCj4gWyA1NjcyLjM0OTQyM10gQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDE4IFsgNTY3Mi4zNTE1MzJdICNQRjog
c3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwgbW9kZSBbIDU2NzIuMzUzMjYyXSAjUEY6
IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UgWyA1NjcyLjM1NDg2MF0gUEdE
IDgwMDAwMDdhZDZhYzcwNjcgUDREIDgwMDAwMDdhZDZhYzcwNjcgUFVEIDdhZjA4OTIwNjcgUE1E
IDAgWyA1NjcyLjM1NjQ0NF0gT29wczogMDAwMCBbIzFdIFNNUCBQVEkNCj4gWyA1NjcyLjM1ODA3
NV0gQ1BVOiA5IFBJRDogNjQ0MjAxIENvbW06IGNjMXBsdXMgVGFpbnRlZDogUCAgICAgICAgICAg
Tw0KPiAgICAgIDUuMTUuNjQtMS1wdmUgIzENCj4gWyA1NjcyLjM1OTc0OV0gSGFyZHdhcmUgbmFt
ZTogU3VwZXJtaWNybyBTdXBlciBTZXJ2ZXIvWDEwRFJDLCBCSU9TIDMuNA0KPiAwNS8yMS8yMDIx
DQo+IFsgNTY3Mi4zNjE0NjVdIFJJUDogMDAxMDpkbWFfZGlyZWN0X3VubWFwX3NnKzB4NDkvMHgx
YTANCj4gWyA1NjcyLjM2MzIyM10gQ29kZTogZWMgMjAgODkgNGQgZDQgNGMgODkgNDUgYzggODUg
ZDIgMGYgOGUgYmIgMDAgMDANCj4gMDAgNDkgODkgZmUgNDkgODkgZjcgODkgZDMgNDUgMzEgZWQg
NGMgOGIgMDUgYWUgZmQgYjAgMDEgNDkgOGIgYmUgNjANCj4gMDIgMDAgMDAgPDQ1PiA4YiA0ZiAx
OCA0OSA4YiA3NyAxMCA0OSBmNyBkMCA0OCA4NSBmZiAwZiA4NCAwNiAwMSAwMCAwMCANCj4gNGMg
OGIgWyA1NjcyLjM2NzAyNF0gUlNQOiAwMDAwOmZmZmZhNGZmNThjN2NkZTAgRUZMQUdTOiAwMDAx
MDA0NiBbIA0KPiA1NjcyLjM2OTAyMF0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAw
MDAwMDAwMDAwMyBSQ1g6DQo+IDAwMDAwMDAwMDAwMDAwMDEgWyA1NjcyLjM3MTA3M10gUkRYOiAw
MDAwMDAwMDAwMDAwMDAzIFJTSToNCj4gMDAwMDAwMDAwMDAwMDAwMCBSREk6IDAwMDAwMDAwMDAw
MDAwMDAgWyA1NjcyLjM3MzAwN10gUkJQOg0KPiBmZmZmYTRmZjU4YzdjZTI4IFIwODogMDAwMDAw
MDAwMDAwMDAwMCBSMDk6IDAwMDAwMDAwMDAwMDAwMDEgWyANCj4gNTY3Mi4zNzQ3OTVdIFIxMDog
MDAwMDAwMDAwMDAwMDAwMCBSMTE6IGZmZmZhNGZmNThjN2NmZjggUjEyOg0KPiAwMDAwMDAwMDAw
MDAwMDAwIFsgNTY3Mi4zNzY0MThdIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6DQo+IGZmZmY4
ODk2OGUxZWMwZDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwIFsgNTY3Mi4zNzgxMzZdIEZTOg0KPiAw
MDAwN2ZmMTAzZDI1YWMwKDAwMDApIEdTOmZmZmY4OTU0N2ZhYzAwMDAoMDAwMCkNCj4ga25sR1M6
MDAwMDAwMDAwMDAwMDAwMA0KPiBbIDU2NzIuMzc5NzYwXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzIFsgNTY3Mi4zODE0MDJdIENSMjogMDAwMDAwMDAw
MDAwMDAxOCBDUjM6IDAwMDAwMDdhZTkwY2MwMDQgQ1I0OiAwMDAwMDAwMDAwMTcwNmUwIFsgNTY3
Mi4zODMwMjNdIENhbGwgVHJhY2U6DQo+IFsgNTY3Mi4zODQ2NzNdICA8SVJRPg0KPiBbIDU2NzIu
Mzg2MjgyXSAgPyB0YXNrX3RpY2tfZmFpcisweDg4LzB4NTMwIFsgNTY3Mi4zODY0NjldIGFhY3Jh
aWQ6IEhvc3QgYWRhcHRlciBhYm9ydCByZXF1ZXN0Lg0KPiAgICAgICAgICAgICAgICBhYWNyYWlk
OiBPdXRzdGFuZGluZyBjb21tYW5kcyBvbiAoMCwxLDQxLDApOg0KPiBbIDU2NzIuMzg3OTIxXSAg
ZG1hX3VubWFwX3NnX2F0dHJzKzB4MzIvMHg1MCBbIDU2NzIuMzkxNDMxXSBhYWNyYWlkOiBIb3N0
IGFkYXB0ZXIgYWJvcnQgcmVxdWVzdC4NCj4gICAgICAgICAgICAgICAgYWFjcmFpZDogT3V0c3Rh
bmRpbmcgY29tbWFuZHMgb24gKDAsMSw0MSwwKToNCj4gWyA1NjcyLjM5MzI3M10gIHNjc2lfZG1h
X3VubWFwKzB4M2IvMHg1MCBbIDU2NzIuMzk3MDc5XSBhYWNyYWlkOiBIb3N0IGFkYXB0ZXIgYWJv
cnQgcmVxdWVzdC4NCj4gICAgICAgICAgICAgICAgYWFjcmFpZDogT3V0c3RhbmRpbmcgY29tbWFu
ZHMgb24gKDAsMSw0MSwwKToNCj4gWyA1NjcyLjM5ODE4MF0gIGFhY19zcmJfY2FsbGJhY2srMHg4
OC8weDNjMCBbYWFjcmFpZF0NCj4NCj4gRG9lcyB0aGF0IGxvb2sgcmVsYXRlZD8NCj4NCj4gPg0K
PiA+IFdlIGFyZSBjdXJyZW50bHkgZGVidWdnaW5nIGFuZCBkaWdnaW5nIGZ1cnRoZXIgZGV0YWls
cyB0byBiZSBhYmxlIHRvIGV4cGxhaW4gaXQgaW4gbXVjaCBkZXRhaWxlZCBmYXNoaW9uLg0KPiA+
IEkgd2lsbCBrZWVwIHlvdSB0aGUgdGhyZWFkIHBvc3RlZCBhcyBzb29uIGFzIHdlIGhhdmUgc29t
ZXRoaW5nIGludGVyZXN0aW5nLg0KPiA+DQo+ID4gU2FnYXINCj4gPg0KPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogSmFtZXMgSGlsbGlhcmQgPGphbWVzLmhpbGxpYXJk
MUBnbWFpbC5jb20+DQo+ID4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxNCwgMjAyMiAxMjoxMyBB
TQ0KPiA+IFRvOiBTYWdhciBCaXJhZGFyIC0gQzM0MjQ5IDxTYWdhci5CaXJhZGFyQG1pY3JvY2hp
cC5jb20+DQo+ID4gQ2M6IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBraG9yZW5rb0B2aXJ0
dW96em8uY29tOyANCj4gPiBjaHJpc3RpYW5AZ3Jvc3NlZ2dlci5jb207IGFhY3JhaWRAbWljcm9z
ZW1pLmNvbTsgRG9uIEJyYWNlIC0gQzMzNzA2IA0KPiA+IDxEb24uQnJhY2VAbWljcm9jaGlwLmNv
bT47IFRvbSBXaGl0ZSAtIEMzMzUwMyANCj4gPiA8VG9tLldoaXRlQG1pY3JvY2hpcC5jb20+OyBs
aW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgTGludXggS2VybmVsIA0KPiA+IE1haWxpbmcgTGlz
dCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDAvMV0gYWFjcmFpZDogSG9zdCBhZGFwdGVyIEFkYXB0ZWMgNjQwNSANCj4gPiBjb25zdGFu
dGx5IHJlc2V0cyB1bmRlciBoaWdoIGlvIGxvYWQNCj4gPg0KPiA+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IA0KPiA+IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+DQo+ID4gT24gVGh1LCBPY3QgMjcsIDIwMjIgYXQg
MToxNyBQTSA8U2FnYXIuQmlyYWRhckBtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4g
PiBIaSBKYW1lcyBhbmQgS29uc3RhbnRpbiwNCj4gPiA+DQo+ID4gPiAqTGltaXRpbmcgdGhlIGF1
ZGllbmNlIHRvIGF2b2lkIHNwYW1taW5nKg0KPiA+ID4NCj4gPiA+IFNvcnJ5IGZvciBkZWxheWVk
IHJlc3BvbnNlIGFzIEkgd2FzIG9uIHZhY2F0aW9uLg0KPiA+ID4gVGhpcyBvbmUgZ290IG1pc3Nl
ZCBzb21laG93IGFzIHNvbWVvbmUgZWxzZSB3YXMgbG9va2luZyBpbnRvIHRoaXMgYW5kIGlzIG5v
IGxvbmdlciB3aXRoIHRoZSBjb21wYW55Lg0KPiA+ID4NCj4gPiA+IEkgd2lsbCBsb29rIGludG8g
dGhpcywgbWVhbndoaWxlIEkgd2FudGVkIHRvIGNoZWNrIGlmIHlvdSAob3Igc29tZW9uZSBlbHNl
IHlvdSBrbm93KSBoYWQgYSBjaGFuY2UgdG8gdGVzdCB0aGlzIHRob3JvdWdobHkgd2l0aCB0aGUg
bGF0ZXN0IGtlcm5lbD8NCj4gPiA+IEkgd2lsbCBnZXQgYmFjayB0byB5b3Ugd2l0aCBzb21lIG1v
cmUgcXVlc3Rpb25zIG9yIHRoZSBjb25maXJtYXRpb24gaW4gYSBkYXkgb3IgdHdvIG1heC4NCj4g
Pg0KPiA+IERpZCB0aGlzIGV2ZXIgZ2V0IGxvb2tlZCBhdD8NCj4gPg0KPiA+IEFzIHRoaXMgZXhh
Y3QgcGF0Y2ggd2FzIG1lcmdlZCBpbnRvIHRoZSB2ZW5kb3IgYWFjcmFpZCBhIHdoaWxlIGFnbyBJ
J20gbm90IHN1cmUgd2h5IGl0IHdvdWxkbid0IGJlIGdvb2QgdG8gbWVyZ2UgdG8gbWFpbmxpbmUg
YXMgd2VsbC4NCj4gPg0KPiA+IFZlbmRvciBhYWNyYWlkIHJlbGVhc2Ugd2l0aCB0aGlzIHBhdGNo
IG1lcmdlZDoNCj4gPiBodHRwczovL2Rvd25sb2FkLmFkYXB0ZWMuY29tL3JhaWQvYWFjL2xpbnV4
L2FhY3JhaWQtbGludXgtc3JjLTEuMi4xLQ0KPiA+IDYwDQo+ID4gMDAxLnRneg0KPiA+DQo+ID4g
Pg0KPiA+ID4NCj4gPiA+IFRoYW5rcyBmb3IgeW91ciBwYXRpZW5jZS4NCj4gPiA+IFNhZ2FyDQo+
ID4gPg0KPiA+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9t
OiBKYW1lcyBIaWxsaWFyZCA8amFtZXMuaGlsbGlhcmQxQGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDI3LCAyMDIyIDE6NDAgQU0NCj4gPiA+IFRvOiBNYXJ0aW4gSy4g
UGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KPiA+ID4gQ2M6IEtvbnN0YW50
aW4gS2hvcmVua28gPGtob3JlbmtvQHZpcnR1b3p6by5jb20+OyBDaHJpc3RpYW4gDQo+ID4gPiBH
cm/Dn2VnZ2VyIDxjaHJpc3RpYW5AZ3Jvc3NlZ2dlci5jb20+OyBsaW51eC1zY3NpQHZnZXIua2Vy
bmVsLm9yZzsgDQo+ID4gPiBBZGFwdGVjIE9FTSBSYWlkIFNvbHV0aW9ucyA8YWFjcmFpZEBtaWNy
b3NlbWkuY29tPjsgU2FnYXIgQmlyYWRhcg0KPiA+ID4gLQ0KPiA+ID4gQzM0MjQ5IDxTYWdhci5C
aXJhZGFyQG1pY3JvY2hpcC5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IA0KPiA+ID4g
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBEb24gQnJhY2UgLSBDMzM3MDYgDQo+ID4g
PiA8RG9uLkJyYWNlQG1pY3JvY2hpcC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
IDAvMV0gYWFjcmFpZDogSG9zdCBhZGFwdGVyIEFkYXB0ZWMgNjQwNSANCj4gPiA+IGNvbnN0YW50
bHkgcmVzZXRzIHVuZGVyIGhpZ2ggaW8gbG9hZA0KPiA+ID4NCj4gPiA+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IA0KPiA+
ID4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBPY3QgMTks
IDIwMjIgYXQgMjowMyBQTSBLb25zdGFudGluIEtob3JlbmtvIDxraG9yZW5rb0B2aXJ0dW96em8u
Y29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24gMTAuMTAuMjAyMiAxNDozMSwgSmFtZXMg
SGlsbGlhcmQgd3JvdGU6DQo+ID4gPiA+ID4gT24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgMTA6NDEg
UE0gTWFydGluIEsuIFBldGVyc2VuIA0KPiA+ID4gPiA+IDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xl
LmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+IENocmlzdGlh
biwNCj4gPiA+ID4gPj4NCj4gPiA+ID4gPj4+IFRoZSBmYXVsdHkgcGF0Y2ggKENvbW1pdDogMzk1
ZTVkZjc5YTk1ODhhYmYpIGZyb20gMjAxNyANCj4gPiA+ID4gPj4+IHNob3VsZCBiZSByZXBhaXJl
ZCB3aXRoIEtvbnN0YW50aW4gS2hvcmVua28gKDEpOg0KPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPj4+
ICAgIHNjc2k6IGFhY3JhaWQ6IHJlc3VycmVjdCBjb3JyZWN0IGFyYyBjdHJsIGNoZWNrcyBmb3IN
Cj4gPiA+ID4gPj4+IFNlcmllcy02DQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+IEl0IHdvdWxkIGJl
IGdyZWF0IHRvIGdldCB0aGlzIHBhdGNoIHJlc3VibWl0dGVkIGJ5IEtvbnN0YW50aW4gDQo+ID4g
PiA+ID4+IGFuZCBhY2tlZCBieSBNaWNyb2NoaXAuDQo+ID4gPg0KPiA+ID4gQ2FuIHdlIG1lcmdl
IHRoaXMgYXMgaXMgc2luY2UgbWljcm9jaGlwIGRvZXMgbm90IGFwcGVhciB0byBiZSBtYWludGFp
bmluZyB0aGlzIGRyaXZlciBhbnkgbW9yZSBvciByZXNwb25kaW5nPw0KPiA+ID4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IERvZXMgdGhlIHBhdGNoIG5lZWQgdG8gYmUgcmViYXNlZD8NCj4gPiA+ID4N
Cj4gPiA+ID4gSmFtZXMsIGkgaGF2ZSBqdXN0IGNoZWNrZWQgLSB0aGUgb2xkIHBhdGNoICh2Mykg
YXBwbGllcyBjbGVhbmx5IG9udG8gbGF0ZXN0IG1hc3RlciBicmFuY2guDQo+ID4gPiA+DQo+ID4g
PiA+ID4gQmFzZWQgb24gdGhpcyBpdCBsb29rcyBsaWtlIHNvbWVvbmUgYXQgbWljcm9jaGlwIG1h
eSBoYXZlIGFscmVhZHkgcmV2aWV3ZWQ6DQo+ID4gPiA+ID4gdjMgY2hhbmdlczoNCj4gPiA+ID4g
PiAgICogaW50cm9kdWNlZCBhbm90aGVyIHdyYXBwZXIgdG8gY2hlY2sgZm9yIGRldmljZXMgZXhj
ZXB0IGZvciBTZXJpZXMgNg0KPiA+ID4gPiA+ICAgICBjb250cm9sbGVycyB1cG9uIHJlcXVlc3Qg
ZnJvbSBTYWdhciBCaXJhZGFyIChNaWNyb2NoaXApDQo+ID4gPiA+DQo+ID4gPiA+IFdlbGwsIGJh
Y2sgaW4gdGhlIHllYXIgMjAxOSBpJ3ZlIGNyZWF0ZWQgYSBidWcgaW4gUmVkSGF0IA0KPiA+ID4g
PiBidWd6aWxsYQ0KPiA+ID4gPiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcu
Y2dpP2lkPTE3MjQwNzcNCj4gPiA+ID4gKHRoZSBidWcgaXMgcHJpdmF0ZSwgdGhpcyBpcyBkZWZh
dWx0IGZvciBSZWRoYXQgYnVncykNCj4gPiA+ID4NCj4gPiA+ID4gSW4gdGhpcyBidWcgU2FnYXIg
QmlyYWRhciAod2l0aCB0aGUgZW1haWwgQG1pY3JvY2hpcC5jb20pIA0KPiA+ID4gPiBzdWdnZXN0
ZWQgbWUgdG8gcmV3b3JrIHRoZSBwYXRjaCAtIGkndmUgZG9uZSB0aGF0IGFuZCBzZW50IHRoZSB2
My4NCj4gPiA+ID4NCj4gPiA+ID4gQW5kIG5vdGhpbmcgaGFwcGVuZWQgYWZ0ZXIgdGhhdCwgYnV0
IGluIGEgfnllYXIgKDIwMjAtMDYtMTkpIHRoZSANCj4gPiA+ID4gYnVnIHdhcyBjbG9zZWQgd2l0
aCB0aGUgcmVzb2x1dGlvbiBOT1RBQlVHIGFuZCBhIGNvbW1lbnQgdGhhdCBTNiB1c2VycyB3aWxs
IGZpbmQgdGhlIHBhdGNoIHVzZWZ1bC4NCj4gPiA+ID4NCj4gPiA+ID4gaSBzdXBwb3NlIFM2IGlz
IHNvIG9sZCB0aGF0IFJlZEhhdCBqdXN0IGRvZXMgbm90IGhhdmUgY3VzdG9tZXJzIA0KPiA+ID4g
PiB1c2luZyBpdCBhbmQgTWljcm9jaGlwIGNvbXBhbnkgaXRzZWxmIGlzIGFsc28gbm90IHRoYXQg
aW50ZXJlc3RlZCBpbiBoYW5kbGluZyBzbyBvbGQgaGFyZHdhcmUgaXNzdWVzLg0KPiA+ID4gPg0K
PiA+ID4gPiBTb3JyeSwgaSB3YXMgdW5hYmxlIHRvIGdldCBhIGZpbmFsIGFjayBmcm9tIE1pY3Jv
Y2hpcCwgaSd2ZSANCj4gPiA+ID4gd3JpdHRlbiBkaXJlY3QgZW1haWxzIHRvIHRoZSBhZGRyZXNz
ZXMgd2hpY2ggaXMgZm91bmQgaW4gdGhlIA0KPiA+ID4gPiBpbnRlcm5ldCwgdHJpZWQgdG8gY29u
bmVjdCB2aWEgbGlua2VkaW4sIG5vIGx1Y2suDQo+ID4gPiA+DQo+ID4gPiA+IC0tDQo+ID4gPiA+
IEtvbnN0YW50aW4gS2hvcmVua28NCg==
