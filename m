Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08994CA2DE
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Mar 2022 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbiCBLIE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Mar 2022 06:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiCBLH6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Mar 2022 06:07:58 -0500
X-Greylist: delayed 4157 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 03:07:13 PST
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02hn2207.outbound.protection.partner.outlook.cn [139.219.146.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4216F499
        for <linux-scsi@vger.kernel.org>; Wed,  2 Mar 2022 03:07:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh1W+zO6M/tPpxk1lp5Ckw34F/BR24ocenCYbjBaLirGWRYGhPVgRxA7/9gKQcEcuJkI9MnmTcjugHi1tOcMzIn3C3CRZ3fd3CQ0/LK2ty9wYhQtThBr6eE6PvbtWhXPrNhDeziRXYvORCLwZwUQHu/E6dHyKWIBA2G+qZX76yuSvubKyV278opGeuvV6H1b8EsaiEsJ4gIosw5SmGrJZrCXl2x4gDz5CH/yBXD2fzayAurEiSFw1GNjoQ/WgYIMReZiMZCfuIuxHt0KSzXAVs/RpB4z6aAjhuoEAMwxbDUSahHq9ogmWIJfIS6OmwYRiWjq5wDGKAyLtiyK8sCi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5770vuUmeYO00QSXqAiD86/7RjYbpOtU3t9VV0XbSJ8=;
 b=erOfm2QOCf7siep57e4nRaVeSZ+ZyEVtzBTFTDiTDm4dMGDftGe4DTmp6cOeHNtVV+mViIc/r2Qz1ovQxNyhBzg1ZlKq4EDwTngB3Iguq4pa1LbgKuqE/JMUpigwkp55Ikg/iV4RaKMAAVu69qxt1iMeFsKk+9RfUMp4c+kevXnkYnhedxq8K0HJHTD+g0mg4YkN/37C9532S3hs5XRjLMwfoUhxNiW8v7XaiIAbS+vzXWrA7bD6qbJXLK8FmsIe3vRcd+yaFVKix9jCGoC8pIHLVH1OypXJIUfiXuVXyLfNI3Je6rO/QyLlzG4gDwX4iM0lO9GRA6fyz5SfM8Jg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pactera.com; dmarc=pass action=none header.from=pactera.com;
 dkim=pass header.d=pactera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pactera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5770vuUmeYO00QSXqAiD86/7RjYbpOtU3t9VV0XbSJ8=;
 b=Q+OI4SzZHrjmHqFI/YUqo1N67t7F4ZmBhJlsdnAhkCc8MXO2s67gKk0r7TGL+Vue91Tz3qj19EpkUF7D2RMLytCMd9mdMMJNsWBrVB8VvYROmgM9QmJLDIN0EtAcH1+8m4Saz77nhLrHhLTfPurEcyq1nYwSWPBVcVyuXSHETb/3mDaH8WUKoE0kDzEXcjRignKXGLvlXhbcL7+JsIXE2Y01DWy1nxIAuhN8lnchqA36E4ai1ZrwcQHklzt37+zpjgZ8fjykqh+fDvKGZLhI3lgIQwGHO8u0A9kWXQmnjVM2nlKTiOOe0+dVAB+ECUC/fWNLRAc0PfKD2itnWyfpuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pactera.com;
Received: from BJXPR01MB0805.CHNPR01.prod.partner.outlook.cn (10.43.36.205) by
 BJXPR01MB0517.CHNPR01.prod.partner.outlook.cn (10.43.32.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.27; Wed, 2 Mar 2022 09:25:29 +0000
Received: from BJXPR01MB0805.CHNPR01.prod.partner.outlook.cn ([10.43.36.205])
 by BJXPR01MB0805.CHNPR01.prod.partner.outlook.cn ([10.43.36.205]) with mapi
 id 15.20.5017.027; Wed, 2 Mar 2022 09:25:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     me <sheng.chang@pactera.com>
From:   "clay" <sheng.chang@pactera.com>
Date:   Wed, 02 Mar 2022 09:05:05 +0000
Reply-To: claytousey@hotmail.com
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn (10.43.33.22)
 To BJXPR01MB0805.CHNPR01.prod.partner.outlook.cn (10.43.36.205)
Message-ID: <BJXPR01MB08052C2302A44346A70302CFFF039@BJXPR01MB0805.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46b1f1e4-5769-409f-b12b-08d9fc2bd2a4
X-MS-TrafficTypeDiagnostic: BJXPR01MB0517:EE_
X-Microsoft-Antispam-PRVS: <BJXPR01MB0517B2E2B13331BD7BEADD88FF039@BJXPR01MB0517.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWZUSGFkcjZtWmp3blVWNng0VDN2RWhtdnZPZEpGRmJFSUhxejUyaGFZNXJM?=
 =?utf-8?B?U3RodDhta09OQk9wRmdYNGpyblJHeldQQjBXVmVEQ1VNVTJIYlYrano5RnYr?=
 =?utf-8?B?SlhUTnlJbTNvQitvSWowN2NXZmp6S0Rtd0hZR3lxTys3elBJSmNwRjVEcWFy?=
 =?utf-8?B?TnBNVTZMakpuNk9hSnYwUCtWbnFXSTJUSlltdkpxdmgxME9oZktjKzdLVldK?=
 =?utf-8?B?ZjUvZnlPU2V0WDU5MVYvMlB3ODdJcjNieHNwaGhhb3hiRWh5YWU3TWl0OXY5?=
 =?utf-8?B?bkgwUml4dDRjREsza3Ntd1YyN3g2enFoUFdEaVBKOS9nNnNnVUR3TFlRWFNE?=
 =?utf-8?B?TUtKSVNuOFR2bmlGbTA2NWZQMUdld1RtWlpRTjh0clRkVFdKc0djQ0E3YjVs?=
 =?utf-8?B?cmpZODE1VEo3Y1dOeDdEL29GR1ZaY2JBb1pLMUNmNEUzTnBGREJNQmNLZWth?=
 =?utf-8?B?YzY0Rk9KdXNSQnJrU3A3bUI4bkFXV21LTVZYdmxZQmJGUW1QWW1lWWR0d2JE?=
 =?utf-8?B?RmJUUzhscEIrejN4K3Z0Y1JvM2Roajl6N2R6dTFIK1V6OFQ0SzN4b1c2MXV5?=
 =?utf-8?B?eEh5TG1NVENQZ2ZseXA0V0llRlhMbE0vcjVuTDVhUk9SUXo3Ti9iVkdKdVRk?=
 =?utf-8?B?MGp6UjlRcGFNL3VjR21vNlhpUFFteGppUTF0c1pONUUvVGNzRVpJR0g3NE1z?=
 =?utf-8?B?cDFTc3pHQnl1bVkvdHAzbndGQzBjSkkyZDZTVHRmb1VyOURtMDRGa3BpbkFK?=
 =?utf-8?B?cHA4ekpoa0xoUVg0WGRtZFZ3MGJyZWtsOWlTV3ZUNFZibGhYdytUSjFySlps?=
 =?utf-8?B?VFFGdU9TM01RR0x4TjVSQStXdjZXMFNITnE0YnZEb1VIN2NvVitWVmFHbTNz?=
 =?utf-8?B?Z2R4Z21MVVQxRlc0cjBpdkVPTlFpanNzeUtjWXl2SFJUdU9PbTQ1dVVQeU5P?=
 =?utf-8?B?b2dqQUM1ckJFMTM4cmVrWVYyYmJucjBScXRJemVwZTdwVXV5cnZaQlRFQnRn?=
 =?utf-8?B?TnRXQVV2NElnYmxobkJRWUtQRG9TNG9ra2hiUndxc2JpQ3NHczM4VHdidFV5?=
 =?utf-8?B?MkdCOENDRkY5NFhxN1ZLRFJtOFkwTnpBR0RWdWoxcFRQRDBDKzkrMjZ6NHhz?=
 =?utf-8?B?aDJaRFZ5aFVtNFBHZkU4SlduNVhFa3ZZYXgwNHpGS1dNT1NqVGFwbFZIL3Fj?=
 =?utf-8?B?TjZBeG9ZVHFkdWZvNTlTTk5lWVBsVzJRQ2JDVExYVXZlclcwUlI5T2piWGVo?=
 =?utf-8?B?TmJGZU9qU1QvWXVaNmYzV2czbzMvQUNiT0RRdDQ0NXVKUnJRZGRrMXM5OXh4?=
 =?utf-8?B?YjNFMjFWbldiSnhxWkxCNlM1N3FjU3NUWUl2dElUeVdzNFdiTHoyTGhWV3JP?=
 =?utf-8?Q?OtyhxEZ5lZf0mwufOyLi4nq8GSjoKBFc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:de;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BJXPR01MB0805.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(8936002)(7116003)(66476007)(66556008)(6862004)(8676002)(5660300002)(26005)(40160700002)(2906002)(7366002)(86362001)(7406005)(2860700004)(7416002)(508600001)(6666004)(66946007)(55016003)(9686003)(7696005)(52116002)(38100700002)(38350700002)(3480700007)(33656002)(6200100001)(40180700001)(186003)(558084003)(18780700002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OThValpOWVlFS285Tk5yOTZST1Y3TUxCUU5tSEM2b1ZvTVlDTU9NUWdRUGJ1?=
 =?utf-8?B?dHVOVTBkQjVSY1FLN0xXK1BXQkdqaU41ZjJXQzN6aXE2cG9teHRJS29mRlhV?=
 =?utf-8?B?TXVWeUdIMjZBUmw4YXZLQm10OHU2akFHRFdnUTU0RHhqcXNpVWI2ZTBFS2Ez?=
 =?utf-8?B?eTV1Q3lVZjVWSVpKWGxFQWx5Skx1SkhnRWhYeU42WGpQS0x1ZUQvR0E1TEps?=
 =?utf-8?B?cm5TaEJyNkVyT1M5SEphL0huWng5WjBUV1hYVzlDL3Z2V2ZYb2NIdXZINU5o?=
 =?utf-8?B?S2lSMFk0ZXZUR0YrbGZMY2IxaS82Q3hCMDBNcVdFYUY3Q3NwQ0VuL09OM2N5?=
 =?utf-8?B?SVRiczl5aFAwSjV1bjdSNWxhbjF6cFdCMlRBV3JvQjQxNStzTWFNSzlrT01X?=
 =?utf-8?B?cEZYQTcydkpqVmRUT2YydWxydFdUR1BuWUlEOXJvNDl2bVVoZ2pTVGtDTkhJ?=
 =?utf-8?B?WHRwN1I5MFZpV0YzakhFeXJQZVdWSjhqNWRGUEpBL3d5U2tmKzUvSWlQallQ?=
 =?utf-8?B?cEhqellXWFJpYWEvZjNsaGxxZ1F2Sk1kM0d2cmdLN0lGSTFxS0NoRm9vdWlS?=
 =?utf-8?B?SHJvdGRHMis4WHNjUkJvZVVnV3dya1RCSUthQXdzUndNYWgxR1hqRmpaM1Nx?=
 =?utf-8?B?MWFVME1PZ2UvRHVDNk5UdlVBM0FUYjlHc1ZwYkFTLy9DdHB2a3hMNmlQa0lY?=
 =?utf-8?B?cjhYeURubk8xellkbjhpUVRNcXBQbThVVHFZZE5kcmg1VTJNL2hSV3F6ZWc5?=
 =?utf-8?B?azMwc3F5RytBWE1aQ0ZmUndaNUVscnZJRkYwQ0RYN21NSjBSSDBkNjBGUHBN?=
 =?utf-8?B?a2NhVFQvcXBJbVVicW1aQ2JwMnFxaCtUZmZ1MmJCeTcvRFN6eEg5VHFVMHFh?=
 =?utf-8?B?R1BoS0RPSisyQlN6R05xbW1jQzNaUGZremNidUlCNHp2ajIvYTJScStsU0ND?=
 =?utf-8?B?OEtTU2FDbVNkd1l4dUZmdVhLeHJQREtyY0Q2bDVUd1hHdUFGblJOcmVvd0Zt?=
 =?utf-8?B?WHZwQjFpQlVUSjRZTVdIYkdzMGxZQlhJMzBkRmkwbm1OZFBJb2pMRmdNRGow?=
 =?utf-8?B?Wk9aeGJDcEZRMkMrclR1YldRZEZqN1IrZjdwalhIa2w2alZjaCtDdzJ0emNI?=
 =?utf-8?B?SDlxS2dpNnZiQ3JkZHRKOHhsS1VhRDVuYUN1YU9vZ1JvNDI4a3Jhcm90NVh1?=
 =?utf-8?B?VFRhU3hyRmUyb05kTXhlSUdUMFNGc2tTdmhBdWpKS3JrLzliQjdPeDNUbm9r?=
 =?utf-8?B?b0NyTWtsTTAwMjQvRzZaaUhOVTRXMUFuMkRUalFXNUQzUzlCRnBZK3FPSGl1?=
 =?utf-8?B?UGZ6T2dWSU9wY0E4TkVmQW8zNWdHLzhnV2VTVnFEOHprNGdqcnhOanNXazlw?=
 =?utf-8?B?ZkJKQWN2WkROMStJY2Z2SThwWEVodDA4bmNuUjFwRUtBZXE5RVZXck5TR0JV?=
 =?utf-8?B?SkdFdlkvYTZyR0JQWjlGbm42aklneVlFQUtNRjFQcnhDTnRZc2xCc1Y4Ulhk?=
 =?utf-8?B?S2V4SzlGWjJaQWFtckdmdGlxZjlLWWxBdVY2c3dSTjlDaVVwYnFMbHRTWGRI?=
 =?utf-8?B?VXFpUVBtWmJKS2pyVEdHMHRFSVhyeEFOOTQ3U1JBc01rOXRwR3FIZjRLVEJa?=
 =?utf-8?B?WmhXNWxZVFV3MkNZNEdrS1lVSWZjRE1HV0ZxSGxWdkhzbUZ3b3dkQm54anhI?=
 =?utf-8?B?Tk1sWjdUZ2hibGVhWDI3MUdLQ0NpMmhSWnBEaGJYbXZtRVRONUYvai9Ma2VN?=
 =?utf-8?B?UDBBMGtVSWdlTkR2S3hUNkEwenRPVFBhK29aWVRaWmNwOFJHcFNuTWFYMUta?=
 =?utf-8?B?cml4aEpEMGh2TC9EbXJVY1JFR01MTnVRN3A2akNldHhIWkhQOWVUTE11RlFC?=
 =?utf-8?B?QzdoQTdHMUZ3WjIrOElJRUdPS0FvQnFpVFRYdWFDVFNxSGpsODBTYVZTMlFu?=
 =?utf-8?B?U2Zra1BVbjBqdkJUbTFEZE9DeFVLTVJlV0tINU1uWVZrOUZjbUdxdmtoSXlZ?=
 =?utf-8?B?WFA2SHpIbHRhY0JEQktnQld4RnZsT29oa05LbmpaaFhWNnMxcVI4WURFNzZv?=
 =?utf-8?B?Q3dweGsrSmJ5M0t2MW9BMkJYNHpvVnVYYWxPZz09?=
X-OriginatorOrg: pactera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b1f1e4-5769-409f-b12b-08d9fc2bd2a4
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0805.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 09:05:39.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSzQfyw/no/+NLlKwmp0KfTAeLQcHQlIKrPHKum2ES53E5cnDbgdPOjvpveMG7uH6D+2GQCllHDfkr14sAIArg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0517
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,FREEMAIL_FORGED_REPLYTO,KHOP_HELO_FCRDNS,
        NIXSPAM_IXHASH,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [139.219.146.207 listed in wl.mailspike.net]
        *  3.0 NIXSPAM_IXHASH http://www.nixspam.org/
        *  0.0 SPF_NONE SPF: sender does not publish an SPF Record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FORGED_SPF_HELO No description available.
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  0.3 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sie haben eine Spende von 3.800.000,00 =E2=82=AC. von Clay Tousey antworten=
 Sie mit diesem Code [CT485342022], um die Spende zu erhalten
