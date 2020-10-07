Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B27286589
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Oct 2020 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgJGRNB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Oct 2020 13:13:01 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57386 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726707AbgJGRNB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Oct 2020 13:13:01 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 097HA0PT015296;
        Wed, 7 Oct 2020 10:12:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=WD7AvrZGYpLFK/U5aqrNMVal8DD23I37slU+OojZ1cA=;
 b=fMd0VwgwLSpwdHrCKXGb4kP1Erqjklh9FRVQpAZ3UkwvIdDNXKO69BBtv8NFKnAqkEuB
 SK/GlSSQdh/NZ/Bgf7DKCVdeR1ymVTJOvNVsMznrCSnP663N19U2clSs6wLYVf6Mcm+j
 CvRGa1pHB60BQqy3pwk2TivD5BDnlWJIIS/4sQkWQFLH59X5TKELkPx7pK7SLJAKOOmw
 PktQl0Q9XikusehSsAFEJOn2zUjR+GrCXys60u5Hx1RvD2v0RhM5ZWF6+DvRIRKhWy0S
 uip7TotJnE6S4rO+GHiL9dES9/9bp/MD1qXoWt/t/whgA+po+oqpvZweJO4qulRxEhTx 1Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 33xpnpwqva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 10:12:51 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Oct
 2020 10:12:50 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Oct
 2020 10:12:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Oct 2020 10:12:49 -0700
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id 6C31D3F703F;
        Wed,  7 Oct 2020 10:12:49 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 097HCmxc031270;
        Wed, 7 Oct 2020 10:12:49 -0700
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Wed, 7 Oct 2020 10:12:48 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     Qinglang Miao <miaoqinglang@huawei.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] scsi: qla2xxx: Convert to
 DEFINE_SHOW_ATTRIBUTE
In-Reply-To: <20200919025202.17531-1-miaoqinglang@huawei.com>
Message-ID: <alpine.LRH.2.21.9999.2010071009280.28578@irv1user01.caveonetworks.com>
References: <20200919025202.17531-1-miaoqinglang@huawei.com>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_10:2020-10-07,2020-10-07 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 18 Sep 2020, 7:52pm, Qinglang Miao wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
> v2: based on linux-next(20200917), and can be applied to
>     mainline cleanly now.
> 
>  drivers/scsi/qla2xxx/qla_dfs.c | 68 ++++------------------------------
>  1 file changed, 8 insertions(+), 60 deletions(-)
> 

Looks good. Thanks Qinglang.

Regards,
-Arun
