Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1EB4DB44
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 22:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfFTUbp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 16:31:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49844 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfFTUbp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 16:31:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KKO7b2045039;
        Thu, 20 Jun 2019 20:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=bzZ/vey85ZOyM6UCX3UVr/ugcoMZG3hCWevREbPYSBk=;
 b=TncfCkCsfsHNQwScZezZFnK49Beecoe1syBOJ2GnbLbTyiTZ5LiT/g1I5qeTmTps9Uk9
 hSa1jwNAgBShYWeWQq+HOex8YdFcoxiVQdQW3LJ7uiu/zcZFTNQSGzcRj3KlpKMQx72A
 HJqmZ13QFau7gb3dQ8TIOlcE3lEjKt1GE0+2tleUoCa6uoYoyjUNhS5KY8exiYon1v/t
 VjfVx+HZErrOY94SOGnI5IolET4cLXk5X5qVALj7nSZ6vCpEUpyEOm9TvuW8Tmoxwaa+
 9Uj1Q9IKPicDKBx/57dxGHz0whUGfgut9x1LyprmYfkB2tkjP08t+C/sq2wY+Y5tvsr7 ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t7809k52q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:31:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KKVeJN004907;
        Thu, 20 Jun 2019 20:31:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t77yntttb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:31:39 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5KKVY19028073;
        Thu, 20 Jun 2019 20:31:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 20:31:34 +0000
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH 1/2] scsi: devinfo: BLIST_TRY_VPD_PAGES for SanDisk Cruzer Blade
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
        <20190618013146.21961-2-marcos.souza.org@gmail.com>
        <yq1r27quuod.fsf@oracle.com> <20190619094540.GA26980@continental>
Date:   Thu, 20 Jun 2019 16:31:32 -0400
In-Reply-To: <20190619094540.GA26980@continental> (Marcos Paulo de Souza's
        message of "Wed, 19 Jun 2019 06:45:43 -0300")
Message-ID: <yq18stwrobf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200146
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Marcos,

>> What's your confidence level wrt. all Cruzer Blades handling this
>> correctly? How many devices have you tested this change with?
>
> I've tested three Cruzer Blades that I have at hand, and all of them
> have VPD support, and also checked with a friend of mine that also
> have one. I can't say about "all others" but so far, 4/4 devices that
> I tested have VPD. (They were all SPC-3 or SPC-4 compliant).

That's not a very large sample. However, SanDisk have traditionally been
pretty good wrt. spec compliance.

-- 
Martin K. Petersen	Oracle Linux Engineering
