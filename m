Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8727C662DB
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 02:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfGLA3l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 20:29:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGLA3l (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 20:29:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0O4Js173471;
        Fri, 12 Jul 2019 00:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=mc43yGKFxRqtyzPAZBNO6WQoV7g2BNz8w4rDliUfdGA=;
 b=Gc15rENBlhC094M20gYN8JKsS2irlStcWSbUykf7Olk/J4xpKWtKqmI2ded0D1hAWCq7
 RHUpJ+TaZCCw+VRmwbM6ymCC9DAr05OeL+xNzBq6tRHUD0+a54jmb+45e7FnKn3OlLZB
 O3K1E0BZlW5TRk3ibDj6M4g6DCCUHj2pfD8zxggsTJb+vyZiymS5146hNoOB7ITR7Xlw
 9O+PI9/SR13t2dn8Bx8AUd3Jz6sOkjDQzF3KBzfAt0tCMr0EKLMwv732n4VD2dbxlmAi
 mIr4zTSpfxANvFV3m4aU/34ORMOw4SyXbVMkzG8/WPoIg8oeXHcb0QB/5N3sVxV/tZxn +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tjkkq2u76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:28:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0RVG0057454;
        Fri, 12 Jul 2019 00:28:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tnc8tu6cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:28:31 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C0SUnB014951;
        Fri, 12 Jul 2019 00:28:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 17:28:30 -0700
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V6 4/4] block: Limit zone array allocation size
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
        <20190701050918.27511-5-damien.lemoal@wdc.com>
Date:   Thu, 11 Jul 2019 20:28:27 -0400
In-Reply-To: <20190701050918.27511-5-damien.lemoal@wdc.com> (Damien Le Moal's
        message of "Mon, 1 Jul 2019 14:09:18 +0900")
Message-ID: <yq1sgrc85as.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=642
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=689 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120003
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Damien,

> Limit the size of the struct blk_zone array used in
> blk_revalidate_disk_zones() to avoid memory allocation failures
> leading to disk revalidation failure. Also further reduce the
> likelyhood of such failures by using kvcalloc() (that is vmalloc())
> instead of allocating contiguous pages with alloc_pages().

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
