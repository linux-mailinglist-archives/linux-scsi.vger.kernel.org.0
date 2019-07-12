Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24CF6629D
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 01:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfGKX7i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 19:59:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728757AbfGKX7g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Jul 2019 19:59:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BNv8fs119689
        for <linux-scsi@vger.kernel.org>; Thu, 11 Jul 2019 19:59:35 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpc0gxdvh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 11 Jul 2019 19:59:35 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 12 Jul 2019 00:53:45 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 00:53:39 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6BNrZRc55443758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 23:53:35 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B72E32805A;
        Thu, 11 Jul 2019 23:53:35 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D8532805C;
        Thu, 11 Jul 2019 23:53:35 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.176.217])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jul 2019 23:53:34 +0000 (GMT)
Subject: Re: [PATCH] scsi: aha1740: Use !x in place of NULL comparisons
From:   James Bottomley <jejb@linux.ibm.com>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Jul 2019 16:52:04 -0700
In-Reply-To: <20190711234833.27475-1-iamkeyur96@gmail.com>
References: <20190711234833.27475-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071123-0052-0000-0000-000003DDC9BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011411; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230848; UDB=6.00648346; IPR=6.01012123;
 MB=3.00027683; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-11 23:53:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071123-0053-0000-0000-000061A7C64A
Message-Id: <1562889124.2915.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=836 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110262
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 2019-07-11 at 19:48 -0400, Keyur Patel wrote:
> Change (x == NULL) to !x and (x != NULL) to x, to fix
> following checkpatch.pl warnings:
> CHECK: Comparison to NULL could be written "!x".

This is one of our significantly older drivers.  We try not to touch it
unless we really have to, so I'd rather not have patches like this
applied to it.

I also don't really think the replacement adds anything to readability,
so it should probably be removed from the checkpatch warnings.

Thanks,

James

