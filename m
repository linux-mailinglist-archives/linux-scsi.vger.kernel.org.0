Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9507AE67
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jul 2019 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfG3Qul (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 12:50:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47178 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3Qul (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 12:50:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGnhXv122160;
        Tue, 30 Jul 2019 16:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=z+OzfW5DDng5sZF2Uzq9/0gDuwAmmX/lJ7hkaWBxDa8=;
 b=mncpJ9/jHeW6ebDcM3e2thsJAT/0OknzWRp6gjLe8ZPm85tfFIB8IRzhwzOE+E+6M1E1
 Sh3nkkECDukD/RqVOqagcOpiL91QyFmu7bzVB/8TanI5/fWk+C/PFb/SidJy9f0dL3en
 HKwnbr0M7J2GPNhyU/wEr9EwcM3ad9wciOLZH6HqNefZNEG5yFeiBwQesB43k4Y+FLjO
 6kL/z+8dp+TzkUflkT1aJF+MSut6jp3wJ558yFgj0m0VWLTlczfzzWd1pZlHKQP74Ztg
 aIgMy8sr1bGBzeW3WqMtRMM0xIaOST/iGDU55d+lCE1PZmfglsH+8pJr/BJT+zIPxCOk Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u0ejpfs23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:50:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGlhks184473;
        Tue, 30 Jul 2019 16:50:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u2jp466tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:50:35 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6UGoY6o012031;
        Tue, 30 Jul 2019 16:50:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 09:50:33 -0700
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: Fix possible null-pointer dereferences in qla2x00_alloc_fcport()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190729084451.29290-1-baijiaju1990@gmail.com>
Date:   Tue, 30 Jul 2019 12:50:31 -0400
In-Reply-To: <20190729084451.29290-1-baijiaju1990@gmail.com> (Jia-Ju Bai's
        message of "Mon, 29 Jul 2019 16:44:51 +0800")
Message-ID: <yq1imrjmppk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=735
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=803 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300175
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Jia-Ju,

> In qla2x00_alloc_fcport(), fcport is assigned to NULL in the error
> handling code on line 4880:
>     fcport = NULL;

Applied to 5.3/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
