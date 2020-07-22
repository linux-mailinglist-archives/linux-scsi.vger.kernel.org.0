Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37489229941
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Jul 2020 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbgGVNcg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Jul 2020 09:32:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45358 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgGVNcf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Jul 2020 09:32:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MDBLs6026245;
        Wed, 22 Jul 2020 13:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=SGDxiMkv+K/gRs79Axes9Aq4nm/uxe/9Z6BhER1gB0Q=;
 b=M17jaN2xoPQjyzcbNIh3EyAt4L6vYmmCoIqfNEMXNxXt0vzVBRus39mqoBEim2QS4gl0
 ZEADhZS2JBt2F7fKfyR+8i2sOHwxVi7BaCCMheuAGRRXQqWB1nWcDgM5X14uo35sG05r
 zlijQgQbwaef/JC4O3F/g7yEqPNfaQNKx2aCWkHFu1gDe7esOn1Gkr3dq25D71GBzEPQ
 6KS+bJgLAQJnq85Fp3AC5Jeo7nvKeGNeWXiAf1kbeFGXNrLprBeiotYq1hiftxnJR1QC
 wkrlIGy9zAxq9hiRWdKeuXUijIaHYeH2b6QaPXkn5408mQU4LsrY4KDUVXU+jmFwIFfa Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32bs1mk8c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 13:27:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MDPlCB151849;
        Wed, 22 Jul 2020 13:27:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32epb584vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 13:27:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06MDRBYJ029023;
        Wed, 22 Jul 2020 13:27:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jul 2020 13:27:11 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daejun Park <daejun7.park@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Adel Choi <adel.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
Subject: Re: [PATCH v6 0/5] scsi: ufs: Add Host Performance Booster Support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1blk7g1jd.fsf@ca-mkp.ca.oracle.com>
References: <CGME20200713103423epcms2p8442ee7cc22395e4a4cedf224f95c45e8@epcms2p8>
        <963815509.21594636682161.JavaMail.epsvc@epcpadp2>
        <20200722063937.GA21117@infradead.org>
Date:   Wed, 22 Jul 2020 09:27:07 -0400
In-Reply-To: <20200722063937.GA21117@infradead.org> (Christoph Hellwig's
        message of "Wed, 22 Jul 2020 07:39:37 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=1 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220097
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Christoph,

> As this monster seesm to come back again and again let me re-iterate
> my statement:
>
> I do not think Linux should support a broken standards extensions that
> creates a huge share state between the Linux initator and the target
> device like this with all its associated problems.

I spent a couple of hours looking at this series again last night. And
while the code has improved, I do remain concerned about the general
concept.

I understand how caching the FTL in host memory can improve performance
from a theoretical perspective. However, I am not sure how much a
difference this is going to make outside of synthetic benchmarks. What
are the workloads that keep reading the same blocks from media? Or does
the performance improvement exclusively come from the second order
pre-fetching effect for larger I/Os? If so, why is the device's internal
L2P SRAM cache ineffective at handling that case?

-- 
Martin K. Petersen	Oracle Linux Engineering
