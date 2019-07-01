Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDB338B51
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfFGNOr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 09:14:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33380 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfFGNOr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 09:14:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57D98T3156310;
        Fri, 7 Jun 2019 13:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=a36N0fRNwwJCLi4THw/V7SKAP5W8EEWXCmWReLDGRiU=;
 b=DIU05XkM/vLajCwG+K0n6Q3BgxgirYkrPUarjO872kyk4JauuJh+QAylGNGx6Mk4a73L
 4QB1n0PIUvnsdIIhcmhdcGWLX3rbT/GZplj+kk0SrnvLvmtMOKRaoZfQnlXN9e58qmRc
 qgzIlbGNSopZP/kSDz1HX9S4tq64SkJX5ow2br89n5qyV0rYnI5gSF+Pe1W8pAUzAJD2
 cLdvcBNfZlKT/JxVD8fL9NVb2ltS4AlaeCBVI2XBCRQsogmRMTtDKht4HRhzAsai10c/
 LHOBNjoF5/Uyxex4XteAb1kCuL0wZv77a2x18pWtmCVKg0m1/XiORjaYNwy4Z8Hn4jkk 8w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2suj0qx3u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 13:14:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57DEcG0103084;
        Fri, 7 Jun 2019 13:14:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2swnhbaqgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 13:14:38 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57DEXYx022596;
        Fri, 7 Jun 2019 13:14:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 06:14:33 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <megaraidlinux.pdl@broadcom.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: remove set but not used variables 'buff_addr' and 'ci_h'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190525124006.21284-1-yuehaibing@huawei.com>
Date:   Fri, 07 Jun 2019 09:14:30 -0400
In-Reply-To: <20190525124006.21284-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Sat, 25 May 2019 20:40:06 +0800")
Message-ID: <yq1lfydleq1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070093
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


YueHaibing,

> Fixes gcc '-Wunused-but-set-variable' warnings:
>
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_fw_crash_buffer_show:
> drivers/scsi/megaraid/megaraid_sas_base.c:3138:16: warning: variable buff_addr set but not used [-Wunused-but-set-variable]
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_get_pd_list:
> drivers/scsi/megaraid/megaraid_sas_base.c:4426:13: warning: variable ci_h set but not used [-Wunused-but-set-variable]
>
> 'buff_addr' is never used since inroduction in
> commit fc62b3fc9021 ("megaraid_sas : Firmware crash dump feature support")
>
> 'ci_h' is not used since commit 9b3d028f3468 ("scsi: megaraid_sas:
> Pre-allocate frequently used DMA buffers")

Applied to 5.3/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
