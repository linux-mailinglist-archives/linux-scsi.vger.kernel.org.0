Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3444DAE0
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 22:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFTUDo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 16:03:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54712 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfFTUDo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 16:03:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KJwpfu123184;
        Thu, 20 Jun 2019 20:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=NW9H9Fp+xiC4ZJAD1llPQWRa2kvGd0HANhiHQLvgFfo=;
 b=Hz/j7b4WOUNXhLs/QkflvaNDKEuSjxpsgMUfT2MwDhoGo1YCSe/LGa6wBZ0n4VCpYqpp
 eAXHRan5/WQtKnPw0P3HJvUtgmYpElEx1gg60vqMzD9mFr1NhbKJjAnR4Xj08y5AFxnt
 jyExGxGedRDL+CEH27qNhPFteV2+82k+z7RTt5Mlglg8NbN0OPr+Y+ALOi5MFrRJ6FRk
 60ETngq82dWntbJ1J5yft0Vu3Y/5oMl7MvEw7UqyTvpLVyU9ve95DsH1tB1d4tSJKTzI
 FUYRUGtZYU7cnV6bPDu0nBb+qHkdDNhX9GZb7TBjAyZPOhymWP9HwfBciAGEhyqwoxZ7 hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t7809k0k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:02:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KK2qZP136035;
        Thu, 20 Jun 2019 20:02:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t77ypjj96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:02:55 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5KK2lB6004683;
        Thu, 20 Jun 2019 20:02:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 13:02:47 -0700
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] scsi: mvumi: fix build warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190620062622.9979-1-ming.lei@redhat.com>
Date:   Thu, 20 Jun 2019 16:02:44 -0400
In-Reply-To: <20190620062622.9979-1-ming.lei@redhat.com> (Ming Lei's message
        of "Thu, 20 Jun 2019 14:26:22 +0800")
Message-ID: <yq1k1dgrpnf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=866
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=932 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200142
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Ming,

> The local variable 'sg' should be initialized in the failure path of
> mvumi_make_sgl(), otherwise the following build warning is triggered:

Rolled this fix into the mvumi commit.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
