Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FCA630DE8
	for <lists+linux-scsi@lfdr.de>; Sat, 19 Nov 2022 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKSJrP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 19 Nov 2022 04:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiKSJrM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 19 Nov 2022 04:47:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9BAA8C0F
        for <linux-scsi@vger.kernel.org>; Sat, 19 Nov 2022 01:47:11 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AJ7F4Jf009676;
        Sat, 19 Nov 2022 09:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vdHDXcoaP0O6l1oE0Gr4woqUZ6r0UGF6oOOQipm3QHc=;
 b=MvgJylSD4+tvXhW3i1lKYurVaZ/XTRDX68x1kmBSIhkZ4Ix3zRMwYQQhs4FW202SGltq
 JFQ3yfWphET2ommDCDk4Z77nGaUHgPocmRtqX0C39ILYxBSMNqdXywATNyCeNRxDHzvG
 EewQ786AXbyhdbKbpF7ZXrTfubG441GdKDk3bWNvEuUiwt+odcZ8kIcC/wKaxj98WD3X
 GTUMu7vvjEUx9Sd+BpbjnvczSP3nK5M8kvI/yTL9ZYFRjsvi1eM4aU/05/xEaYp9dGW6
 SWx6Ny6E0Lyy+IsTRWHPqicmtjcSv8DKDVhsdDCp5ZxLujtvJQFtqfEVMx2E0TmKQwuM +Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kxtkc9u86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Nov 2022 09:47:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AJ9bNZV017071;
        Sat, 19 Nov 2022 09:46:59 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3kxps8r94y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Nov 2022 09:46:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AJ9kvR41573384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Nov 2022 09:46:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C81252050;
        Sat, 19 Nov 2022 09:46:57 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.37.199])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B847A5204E;
        Sat, 19 Nov 2022 09:46:55 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH 1/2] scsi: alua: Revert "Move a scsi_device_put() call out
 of alua_check_vpd()"
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <2f822744-e137-4aa4-396b-a82348d5d84a@acm.org>
Date:   Sat, 19 Nov 2022 15:16:44 +0530
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Martin Wilck <mwilck@suse.com>,
        Benjamin Block <bblock@linux.ibm.com>
Message-Id: <94DE4EA7-422A-4535-8D16-7EB038D147DB@linux.ibm.com>
References: <20221117183626.2656196-1-bvanassche@acm.org>
 <20221117183626.2656196-2-bvanassche@acm.org>
 <621BAA12-689E-4420-9D63-CC53E77370D5@linux.ibm.com>
 <2cb6d6aa-965c-e716-6110-5b90b634f59a@acm.org>
 <AB48CAF8-B327-4A35-9807-89372F73E8D3@linux.ibm.com>
 <2f822744-e137-4aa4-396b-a82348d5d84a@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: okjS99CwT8WOndS1t8XNyT9MKGyBZ_Ue
X-Proofpoint-GUID: okjS99CwT8WOndS1t8XNyT9MKGyBZ_Ue
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211190067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> On 19-Nov-2022, at 12:24 AM, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> On 11/18/22 08:03, Sachin Sant wrote:
>>> On 18-Nov-2022, at 8:37 PM, Bart Van Assche <bvanassche@acm.org> wrote:
>>> Can you also test patch 2/2 from this series (https://lore.kernel.org/a=
ll/20221117183626.2656196-3-bvanassche@acm.org/)?
>> I tested with both the patches applied on top of next-20221117.
>=20
> Thank you Sachin for having confirmed this. In the future when testing an
> entire patch series, consider replying with "Tested-by:" to the cover let=
ter
> instead of the first patch. I think that is the conventional way to indic=
ate
> that a patch series has been tested in its entirety instead of a single
> patch from a series.
>=20

I did not receive the cover letter so replied to the first patch.=20
I should have explicitly called out that I have tested both the patches.

Sorry about the confusion.

- Sachin=
