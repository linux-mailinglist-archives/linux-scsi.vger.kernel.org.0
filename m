Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5C105E8D
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Nov 2019 03:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfKVCTN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Nov 2019 21:19:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52160 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKVCTN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 21 Nov 2019 21:19:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM2IxBA126127;
        Fri, 22 Nov 2019 02:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=2zVKy8FtHTdWztCQJccE9woCczDrdMZAePdPXZ54Hio=;
 b=b9KnwfKtGecVuXTex8O0Ff6OhTRdsFPxqw2oB/HhTBUmuo0WlQCPIralZG8uP9BQa8px
 rGkjMzZbUXGZQzdxBDQtLCBlzJzTeYHKWbJdrmoNErp8Eo0nQgI/ZBzylNH/meDTOJNl
 DeTFU96V+10B/NOpASJXsNZ4QZcQVYtcf//h/mhtOHBIDXkDcv2EgKeYLrH/K+9+wDX5
 Tlq+pzZyxM7IjbH+1ka8m75qd5IWSwkjPgrn2o1nZut6E3HiF2LdRCXvJ+ak+nJ1RUbk
 CE+rGGgaHgserBk7KNetjPVWOjYvkfb/ALolka2g/F3hlS46Y9OlNrjrmUQ1quBDY0TH 7A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wa9rqyudu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 02:18:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM2HwsR137371;
        Fri, 22 Nov 2019 02:18:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wd47y1g06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 02:18:58 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAM2IuvK015687;
        Fri, 22 Nov 2019 02:18:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 18:18:55 -0800
To:     Hannes Reinecke <hare@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [PATCH 4/4] scsi: core: don't limit per-LUN queue depth for SSD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191118103117.978-1-ming.lei@redhat.com>
        <20191118103117.978-5-ming.lei@redhat.com>
        <1081145f-3e17-9bc1-2332-50a4b5621ef7@suse.de>
Date:   Thu, 21 Nov 2019 21:18:51 -0500
In-Reply-To: <1081145f-3e17-9bc1-2332-50a4b5621ef7@suse.de> (Hannes Reinecke's
        message of "Wed, 20 Nov 2019 11:05:24 +0100")
Message-ID: <yq1y2w8bqlw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=645
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=710 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220019
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hannes,

> I must admit I patently don't like this explicit dependency on
> blk_nonrot().

The whole idea behind using rotational/non-rotational as a trigger for
this is a red herring.

Fast devices also have internal queuing limitations. And more
importantly: Fast devices also experience temporary shortages which can
lead to congestion.

-- 
Martin K. Petersen	Oracle Linux Engineering
