Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E330B7B3AA
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jul 2019 21:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfG3T5a (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 15:57:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60322 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfG3T5a (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 15:57:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UJsZrU083588;
        Tue, 30 Jul 2019 19:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=LFJyyLZxjtgE8rEywk3wp2Ha3oYkXar89dc4CTjTv0Y=;
 b=Cpbp1TK2Hes+5TlgsYdD/yNRKnsLxYUqoVCXxyWVlFsfuUsutYvWH/iOsUIRohOH3GVH
 xC16Ij64MogaNoQMeZemgENw6lteoYH7iRTCMr4/NXhVaBUST/q6yGnadpjVQek4rJyi
 fi/FbojFWqwnDlGy0SmIeG1b1pDcdR8jqhkrYF4pOKvLgs9AVlQ71KagyfUySIYTM+MO
 aZQ72alsjTJgZnt7xHpPgiyEmkWKjxNOdzrlErn0Mlp3QTyv1C5+2B7O9taFl0VdkyP/
 +0iSiYkKL2t+d2DXnvB6RnrteaPubL18WHM24OU2st+T6Ayi8woUgul7RvOyFCUb3RrR 0Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejpgprp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 19:57:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UJqdp1027227;
        Tue, 30 Jul 2019 19:57:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u2exajtuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 19:57:26 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6UJvPv8027162;
        Tue, 30 Jul 2019 19:57:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 12:57:25 -0700
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] scsi: mpt3sas: clean up a couple sizeof() uses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190726065205.GA22701@mwanda>
Date:   Tue, 30 Jul 2019 15:57:22 -0400
In-Reply-To: <20190726065205.GA22701@mwanda> (Dan Carpenter's message of "Fri,
        26 Jul 2019 09:52:05 +0300")
Message-ID: <yq15znjmh25.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=915
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300202
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=972 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300202
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Dan,

> There is a copy and paste bug here.  It uses EVENT_TRIGGERS size instead
> of SCSI_TRIGGERS size but fortunately both size are 84 bytes so it
> doesn't affect runtime.
>
> These days the prefered style is to just say sizeof(object) instead of
> sizeof(type) so I have updated the function to the latest style as well.

Applied to 5.4/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
