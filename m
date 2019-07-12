Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C918662CA
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 02:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfGLAYB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 20:24:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40294 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfGLAYB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 20:24:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0JpFh170785;
        Fri, 12 Jul 2019 00:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=HYlQE+c1teU9A33RM7brccxSFdyltTyRTPhHWge3Gdg=;
 b=UFSugVI/MGi4JmHKsvvE0MDnEPlJkyYH4MkkpcMuHDGBi6TX77YMUZOpW3i8AohVFzTC
 Z6+Wa1g6n5Sd8OLAGdEIhHcJXtY/ki91VL7cQFFiui25IbYli3u8i7FWGPVoyeiax3Z5
 PacAejYCiRj1ygTMyRXPVutGmAB9Xtq6ONwr453q+eqkyuGbVq7ZdDMIro/cPZvjQtH0
 9kT6BSrVUoppwmquINavE0kFe4zwa2NYFVdfW1tco0tUiyneddyEyvuapxqY8oSIOLIv
 Fo9J7ZsJkTU8Xrnt4jyqdNWiVKkRflvRr3WZ2kIlEsKhUPulj8JiRBjhkG5FwfaRaxaS lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tjkkq2twa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:22:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0HUOl090850;
        Fri, 12 Jul 2019 00:22:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tmwgyf9q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:22:49 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C0MlOl029885;
        Fri, 12 Jul 2019 00:22:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 17:22:46 -0700
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V6 1/4] block: Allow mapping of vmalloc-ed buffers
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
        <20190701050918.27511-2-damien.lemoal@wdc.com>
Date:   Thu, 11 Jul 2019 20:22:36 -0400
In-Reply-To: <20190701050918.27511-2-damien.lemoal@wdc.com> (Damien Le Moal's
        message of "Mon, 1 Jul 2019 14:09:15 +0900")
Message-ID: <yq15zo89k4z.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=720
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=776 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120002
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Damien,

> To allow the SCSI subsystem scsi_execute_req() function to issue
> requests using large buffers that are better allocated with vmalloc()
> rather than kmalloc(), modify bio_map_kern() to allow passing a buffer
> allocated with vmalloc().

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
