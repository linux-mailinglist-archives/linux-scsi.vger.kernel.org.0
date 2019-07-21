Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5756F12D
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jul 2019 03:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfGUB02 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 20 Jul 2019 21:26:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39170 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfGUB02 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 20 Jul 2019 21:26:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6L1P20u143374;
        Sun, 21 Jul 2019 01:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=9hHGsPKfR8NAiZ8q14pCvULu4nbcjx7dgUHOR7zIL80=;
 b=TIGiSNaamgeJId5CYLvzohpHgqRpgXIk1BuoOaRfXKxU1KqmGtgzil6T7qu/kg2v4QPO
 GW9t5nvJyeHE56is5stLzsg67k6teaN0tcWR9OIh0xGnPpJWibrQlAXqpDAns2Hhm9jZ
 q3HKMrQC6S9l9Ks4iWk5/YURwkZxEc8Z4EKZgnO9KaG/bDoYx/H5ORah4XK9LPN5EXJM
 l3b6igMmyO9rybtrgKLqe+0aSXFX6EYBsxGklZnAkStPk/DI+MHBIb2bDTCPxh5JgBKf
 M+x0Pt832yo4TqZJmSXvGGtUKq5POSYv2yM02N3KAlVRBPOTln4TpMUwuoF2+zecDmVs aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tuukq9qp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Jul 2019 01:26:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6L1NFMY168708;
        Sun, 21 Jul 2019 01:26:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tuts1xmkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 21 Jul 2019 01:26:14 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6L1Q918030511;
        Sun, 21 Jul 2019 01:26:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Jul 2019 01:26:08 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] fcoe: avoid memset across pointer boundaries
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190604093028.79673-1-hare@suse.de>
        <CAHk-=wheOAo2tQ2mfsSE2iAxxURg62jVt9QsZBL1TPL52aZbvQ@mail.gmail.com>
Date:   Sat, 20 Jul 2019 21:26:06 -0400
In-Reply-To: <CAHk-=wheOAo2tQ2mfsSE2iAxxURg62jVt9QsZBL1TPL52aZbvQ@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 20 Jul 2019 12:21:40 -0700")
Message-ID: <yq1wogcuqj5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9324 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907210014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9324 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907210015
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Linus,

> The gcc-9 warnings are still there, and as annoying as they were
> originally. Appended for your viewing "pleasure" once again, in case
> you don't have gcc-9 installed..

I didn't merge them because Bart had some comments and I was expecting
Hannes to address those and repost.

Hannes: Please fix!

-- 
Martin K. Petersen	Oracle Linux Engineering
