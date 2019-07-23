Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688AC70EF5
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jul 2019 04:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfGWCIi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 22:08:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfGWCIi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Jul 2019 22:08:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6N1rmeC020305;
        Tue, 23 Jul 2019 02:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ZP9hv6fXGU72izgksRJ46DMCGa3wK92WlRJDDHinW9M=;
 b=WQFNCvWefZur+fKmZ4U192HmwXjk761N2Ioody5mbUwGmbx4BXTswvVw4Wkx6Wt+VzVS
 WAjfLm9BHWVYD6TZB72lH44Rq3QhrbBG7JUxOlmWkwbR3mE0Zx/EmCMcUy53GYdbqN7V
 C1P49fXYv1H1Yt/Ug5N7OG+w3iX6w/i99JwrNFgrI9Y25Pe8Lh2CzLZ+sZr7l+EnqEic
 +ZEKsGP49iqbuLnXQHZfKIBXFA9vZlHB67r6dpa5rrBDXn+7Mmsa5N9WSgtsdh+61Cz3
 TK+AV+190fCt/IYXE6BKNumHcBobTjVnHU8YboVeDREfEAlNaSuLvwveZER3Zi6y0rjP Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tuukqk3uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 02:08:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6N27qVL154612;
        Tue, 23 Jul 2019 02:08:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tur2u4f7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 02:08:29 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6N28MqX002581;
        Tue, 23 Jul 2019 02:08:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 19:08:22 -0700
To:     Christoph Hellwig <hch@lst.de>
Cc:     martin.petersen@oracle.com, bvanassche@acm.org,
        tom.leiming@gmail.com, dexuan.linux@gmail.com,
        Damien.LeMoal@wdc.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: fix the dma_max_mapping_size call
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190722092038.17659-1-hch@lst.de>
Date:   Mon, 22 Jul 2019 22:08:14 -0400
In-Reply-To: <20190722092038.17659-1-hch@lst.de> (Christoph Hellwig's message
        of "Mon, 22 Jul 2019 11:20:38 +0200")
Message-ID: <yq1lfwpsdtd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=936
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907230013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907230012
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Christoph,

> We should only call dma_max_mapping_size for devices that have a DMA
> mask set, otherwise we can run into a NULL pointer dereference that
> will crash the system.
>
> Also we need to do right shift to get the sectors from the size in
> bytes, not a left shift.

I queued this up since it breaks stuff for enough people. But I do feel
that some of Bart's concerns may be valid.

-- 
Martin K. Petersen	Oracle Linux Engineering
