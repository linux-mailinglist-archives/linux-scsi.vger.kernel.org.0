Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9F872D649
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Jun 2023 02:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjFMASb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Jun 2023 20:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbjFMARE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Jun 2023 20:17:04 -0400
Received: from ZAF01-CT2-obe.outbound.protection.outlook.com (mail-ct2zaf01hn2032c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e99::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F483598
        for <linux-scsi@vger.kernel.org>; Mon, 12 Jun 2023 17:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLuwKIXmIm+h/rgEPtPRd6sgRbMYGRU6Pz8cNh9kF+e0EPRzObqgtyKb91gFXNLHfZfaCPjDeUTZe7q4xEj+1dcUAfeq9xbwKB0YXfdcFScOVShMRM1epGcwig/JK1OZ8O4CnR4CZAs79IvqlRe4OzVGgnlrU858aQ/vp1DIh8tfvB/P5lWrF4HR8yjy+zRSXJxrhUTg5epMGnWgOR8JtpJxtbaFcYRBy0/ELhYTdVkVP4P/LY0v8jKii2RGSJYZdVGzy8e2ndOrcPSbtInqQ7Qsw8hEVz5zKE38wwwWwUq3h5mk371sJ4PxjAxV6We8NlX/kR+kM+Xdyd/lJNsxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ypllNK1Fapin4wbpo079ajyFvRdaTX3CiXPOxGn2Vw=;
 b=dycFQYr+Bzk/N6sxxBd0pGzZt5PsPSNH4T2+UZ1OMy2Osk+9v7k5mR9Avx9K5m0rSViuDJrg2ABewrBUHfQTnx3FFrnC+zk5yP7GDSu2MIqkH2/CLy3XPY6hV3OtWWUZ0qnyPRXe0V7LNDKxOivylRn68hlY6xf624F6hXRLNtK9ZyE//76ZjsUQYPwPbFgtn7Vq9KE4mRRicZC4KSwk/8XXe6//zavZTOxy0GGbWY7iMFXxW9HMktmR6H99FEfljVb0c44NuuzDqzWNIaOyLb/IDysgi7F+67lcQsEeCaM8EM1CJsPa+8mXMLIgaaypAhHfc77pDnskQcqpjPMUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 196.37.118.239) smtp.rcpttodomain=gmail.com smtp.mailfrom=1service.kz;
 dmarc=none action=none header.from=1service.kz; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mutualandfederal.onmicrosoft.com;
 s=selector1-mutualandfederal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ypllNK1Fapin4wbpo079ajyFvRdaTX3CiXPOxGn2Vw=;
 b=kSjXpmGVKq7e6xyEzlCoZch/zI5qiNWAU3tTZMKE3A2Ct4pewr0KGrFskmdjVrj93oj5yTQBQmT+HlplrHKGC2AaAn0tIengF6sIdwuEhhf+I2B/k9tCAwbnVJHc7Hkew6L9mI5SEcH3V1+O311Agz1QSqfwgDIzvbqKbJzF/0fwi81lxoKxLK0mIc1gSmPKb2W/6o4aSYosGmmk0ujCVR9K0IJwkh1gY1pCA/x3krYFZeQOd7nHpL4iQKOcWDv+X1ffvfiplsPpUGYQRZHIF5yx/nA+Zhn8hszVrrsa95f5LUgxhB8jP+kGWZl52Pnnw9CZYv97K8e2ZkW73Ofvpg==
Received: from GVYP280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f9::18)
 by JN2P275MB0682.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.46; Tue, 13 Jun 2023 00:13:00 +0000
Received: from HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:f9:cafe::e1) by GVYP280CA0043.outlook.office365.com
 (2603:10a6:150:f9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Tue, 13 Jun 2023 00:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 196.37.118.239) smtp.mailfrom=1service.kz; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1service.kz;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 1service.kz discourages use of 196.37.118.239 as permitted sender)
Received: from mail.ominsure.co.za (196.37.118.239) by
 HE1EUR01FT011.mail.protection.outlook.com (10.152.0.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.21 via Frontend Transport; Tue, 13 Jun 2023 00:12:57 +0000
Received: from OMIPRIETN01AP.mufep.net (10.91.31.36) by
 OMIPRIETN01AP.mufep.net (10.91.31.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 13 Jun 2023 02:10:04 +0200
Received: from [87.121.221.62] (87.121.221.62) by OMIPRIETN01AP.mufep.net
 (10.91.31.36) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 13 Jun 2023 02:10:00 +0200
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE: INVESTMENT PROPOSITION:
To:     Recipients <info@1service.kz>
From:   "Edward Stevenson," <info@1service.kz>
Date:   Mon, 12 Jun 2023 17:09:55 -0700
Reply-To: <stevensonedward792@gmail.com>
Message-ID: <7b07de68-ff69-461c-88e6-3742c1ed769a@OMIPRIETN01AP.mufep.net>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT011:EE_|JN2P275MB0682:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc39800-f64c-40e1-3d48-08db6ba2f177
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDFpRDdpVk9iTDF6dXFLekVZam9xRGVvM1ltNnVkZzZIOW9HSVFLcXU4bER0?=
 =?utf-8?B?UGo5RkZaaTZRY2FsYjJ2ZmNickg1bXVRTnNyZXE5aEVEK2psdU82QmhhMjBB?=
 =?utf-8?B?Q0xodzJMUWNXejZEaTZBRFhkbGtxbXZyS3Exa3B1VlpZS1FVVXZ1TTBqdE1I?=
 =?utf-8?B?YUpOcjRLTm1LOGZFZFBFRStxUE9wait2ajc1cnE4cWtwc3pEY0dCLzd2K282?=
 =?utf-8?B?MVgrR3RwWjVRL0NXWFR1MjdxR0JrVEUrWk8zTGVkMm01S0pBYVNJV2NXMmQ2?=
 =?utf-8?B?c2V6MzM3bFZ0R1hZbk44YU16bnRKWlUxc3k4TlNIdFVWcU5Ra1ZDM0ZocVVo?=
 =?utf-8?B?SXlwNTFOQ0lJZk1VamhoQmxoaW90ZGpPOGpTbGVYMnJVMmxybFg4cnNiblp1?=
 =?utf-8?B?dnFaTXEwUStGN2t1U1VudWlYMFdQZkM4SG9VVFNsN1pUOFg4a2xtdm9sUkNl?=
 =?utf-8?B?WmpNempIeVdWOTNVdnFOdDRXd1VtWWV2Z1o1YjA2aUR4dDZVRGgvSkxCeGgz?=
 =?utf-8?B?RDNpalZJT2NPVm13ck8xRFc0dXBpdk9veFY0ekhSc2x5ZU9Nc3VEZy9wV1BP?=
 =?utf-8?B?bVpzcFF4OXZZbHo5RldtNEhseEc5YnZGNVk3T3J4SlJoZzJSSWkrYkdYc28w?=
 =?utf-8?B?Sm5LNjNjSzhDMFlnVTl6cDZ3VVAyTFRRaVQwOEFTL09Kbzd3bDAxR1cvOEpu?=
 =?utf-8?B?blk3elZPL0dhVHluaURmRUYvMU03Mm5XRzFGWkRKUVMycVloVnBBM3BTYnlH?=
 =?utf-8?B?a1FtSFFSVFBvREFGWk9JeVBQbWo0L1NJNEhqNXcyb1A3dC9GdUlTTWxMQkxL?=
 =?utf-8?B?Q3lyckRvNDY3ZTFhL3N2TlptL1VsZkVJVThma2I0L0JvdlhNOWZoTUxxL0Zn?=
 =?utf-8?B?S21ZYW9TbDZleHBvcXBhTGNkQUVsWk9MMXNHY3FIbkxzMk9vOExPZ3h5endV?=
 =?utf-8?B?SEs2ZkRWdjhrTVU0OEsyUG5NNGJwd3VLQjVvcUEzYjV3T0duQ1VvNUQ2VmJK?=
 =?utf-8?B?ZENlZzVhcEFZdzlnMmUyWmtZWlNlaEdnWUQ5ZU9Ga2JPWldqb21MMmdRZkVl?=
 =?utf-8?B?OWVvcmZ5QXRZdEt1SkNzbWZWRC90K2tabzUvVWJ3SGczb1JHTzkwY0wrbVZ6?=
 =?utf-8?B?RC83K2Y1QkxuNTZoM2JkWHdHUUtDaXc4Y05iS3ZWMStQa3RwL3FzNHpFanNh?=
 =?utf-8?B?WjI1QklPRjIzdG9NWkdDVk9xOVh6elhYV2hpYnBUUVBZVzQvNmNJaHJuaXhS?=
 =?utf-8?B?MHRVc0RybnJLdXJ4VjkrK0xMK2FhYVQxaWVGMWtPZVRncVhZSEtrVldxcWE5?=
 =?utf-8?B?U3FnWGdmWGRDSVJ5Vzk1S1U5R2JwS0dXQ0g0bG9vTUpyQlRuVTFaVlR1am9a?=
 =?utf-8?B?U2xWVkZuaEhLYWswZ1k5VlE5dHk2M3dHSFdkQlZ2eWdlL29xbWF0Zjl0NzU1?=
 =?utf-8?B?cEh4STVyN1J3WWcxanNPY1RCSGFwcjJvTXgzWGZIYWtmblJFaFdQOUZzQlZX?=
 =?utf-8?B?UjBReU5KUFRFVkI1Zk5aczJFVEdiRE9DZ0Jpb095Mmh6VEl1VWVuZ3FSa1F5?=
 =?utf-8?Q?78gWWXn2wJodt7GcynE46YDsM=3D?=
X-Forefront-Antispam-Report: CIP:196.37.118.239;CTRY:ZA;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:mail.ominsure.co.za;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(46966006)(40470700004)(40460700003)(6666004)(47076005)(35950700001)(3480700007)(336012)(83380400001)(956004)(31696002)(82310400005)(86362001)(81166007)(9686003)(26005)(356005)(82740400003)(40480700001)(16576012)(5001810100001)(2906002)(7116003)(5660300002)(2860700004)(6862004)(7416002)(8936002)(41300700001)(316002)(31686004)(8676002)(6706004)(66899021)(70586007)(70206006)(6200100001)(508600001)(6320200004);DIR:OUT;SFP:1501;
X-OriginatorOrg: mf.co.za
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 00:12:57.8817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc39800-f64c-40e1-3d48-08db6ba2f177
X-MS-Exchange-CrossTenant-Id: 9cea85f3-a573-4c2a-8071-9288b3c683b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9cea85f3-a573-4c2a-8071-9288b3c683b5;Ip=[196.37.118.239];Helo=[mail.ominsure.co.za]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JN2P275MB0682
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_SBL,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [87.121.221.62 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [stevensonedward792[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

RE: INVESTMENT PROPOSITION:

To Whom It May Concern:

My name is Edward Stevenson. I am a Certified Outsourcing Specialist {COS} =
based in the Republic of Ghana. By virtue of my profession,I have my client=
=E2=80=99s mandate to source for Investment/Fund Manager or Entrepreneur wi=
th wealth of experience from any part of the World  that will be willing an=
d ready to manage my client's  Investment Capital for a long period of 10 y=
ears and above without interference from the ultimate beneficial owner eith=
er directly or indirectly.

Furthermore, you shall retain 15% of the Investment Capital as your Gratifi=
cation, Commission and Investment Management Fees should you find this offe=
r interesting. In addition, you will at the same time ratain 30% Net Profit=
 from the client's Investment Capital for managing the Investment satisfact=
orily. The Return on Investment {ROI} payable annually to my client will be=
 determined by you and finally, you will have a Grace Period of 18 months b=
efore ROI will be paid to my client annually. If you are eminently qualifie=
d to work with us as specified herein, kindly introduce yourself, your comp=
any and what type of business you  do in order to assess your qualification=
s. Moreso, add your WhatsApp Number for more effective communication.


Truly Yours,

Edward Stevenson,CSO
