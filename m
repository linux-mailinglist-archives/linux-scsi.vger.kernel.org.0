Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD769C2C6A
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Oct 2019 06:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfJAEAw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Oct 2019 00:00:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfJAEAw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Oct 2019 00:00:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x913x3Z8122056;
        Tue, 1 Oct 2019 04:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=1QbCS1KuyKgFPFr+yzl4hCG91LVOxJ7GrMkPmO9P3QY=;
 b=ZfCFxRLlw9fcSDxA35LOqD9oJWy1w0SEfbe0ZrDttPNx98KyDXlbvjtVN3lk5yi9eZfv
 YpKJdQq6WYkPbmjW2XGODL1KPGOCIQ7P9IJCapyy80tL++bquS3CH9iXThDEOtkrMUit
 B/2HXRchXU3ySMCFIEgrYT/rCr7Mx4y/CKg110LC7JusE07t0kdeyGXnBHqXI/lfjhiF
 9y26Pp025FIb0Pyrf8fKxpf+hPRXXv0UGXO/zLD1A2Kgw3Tf1MIcLdNF9f4fFBkkfCnp
 EISc/uaKffGJgnG+Nhjtj2KWVw6KdkxQGv5dTSRV5OE2ZWwhrXVdEbzT60/a84YP2ZJH tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v9yfq31hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 04:00:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x913wk8p172594;
        Tue, 1 Oct 2019 04:00:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vbnqbyk4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 04:00:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9140gSe010010;
        Tue, 1 Oct 2019 04:00:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 21:00:41 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] bfa: Make restart_bfa static
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190930094327.46836-1-yuehaibing@huawei.com>
Date:   Tue, 01 Oct 2019 00:00:39 -0400
In-Reply-To: <20190930094327.46836-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Mon, 30 Sep 2019 17:43:27 +0800")
Message-ID: <yq1zhilunbs.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010039
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


YueHaibing,

> Fix sparse warning:
>
> drivers/scsi/bfa/bfad.c:1491:1: warning:
>  symbol 'restart_bfa' was not declared. Should it be static?

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
