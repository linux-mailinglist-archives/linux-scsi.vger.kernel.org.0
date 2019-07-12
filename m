Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFA866388
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 03:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfGLBze (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 21:55:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51730 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfGLBzd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 21:55:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1sW1F036657;
        Fri, 12 Jul 2019 01:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=wjnOtaSUZ2370vEjWwuuNyLly3AoH2cICO3BTNqC9BM=;
 b=yowJJaIOr+HOSklF1TBa1ceXUWgVZyMY7eTPTxXEhJWR5D3f8KZVwtkYFKp1ZQeqNxxN
 OCXP6I5lpvxJLVIuC3r1hIyo3Ykf6ibbKzoDP8lwoKsqe6juYVqYR/FVrqszbRmP/lCa
 kF29RpPoeA7QxFnnd1VYF7g0hc2rMO8Irb2QBxoWjpfqU8Z/sdeCZpVKNGskzFrb3W57
 cBg41qb1C6RdJCyhbcqf23jOFl2w06eVy5+c3avsldmiN3PN2MCm4ENln85bd871Qxdg
 ChA7emIz2jirwnJWubfRNes8EcPiUEdfFktHjzp+iHXD+UcjFh7xA0kYN7cInSrBG/1k HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tjkkq3193-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:54:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1qhne099984;
        Fri, 12 Jul 2019 01:54:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tnc8tvq8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:54:49 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C1sjgW011821;
        Fri, 12 Jul 2019 01:54:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 18:54:45 -0700
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH] scsi: fix race on creating sense cache
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190712014231.5084-1-ming.lei@redhat.com>
Date:   Thu, 11 Jul 2019 21:54:43 -0400
In-Reply-To: <20190712014231.5084-1-ming.lei@redhat.com> (Ming Lei's message
        of "Fri, 12 Jul 2019 09:42:31 +0800")
Message-ID: <yq1d0ig5864.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=830
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=886 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120022
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Ming,

> When scsi_init_sense_cache(host) is called concurrently from different
> hosts, each code path may see that the cache isn't created, then try
> to create a new one, then the created sense cache may be overrided and
> leaked.
>
> Fixes the issue by moving 'mutex_lock(&scsi_sense_cache_mutex)' before
> scsi_select_sense_cache().
>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Fixes: ?
Cc: stable?

-- 
Martin K. Petersen	Oracle Linux Engineering
