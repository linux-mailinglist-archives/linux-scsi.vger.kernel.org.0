Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE181E40EE
	for <lists+linux-scsi@lfdr.de>; Fri, 25 Oct 2019 03:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbfJYBSp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Oct 2019 21:18:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55982 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388515AbfJYBSo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 24 Oct 2019 21:18:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P1DwfJ115537;
        Fri, 25 Oct 2019 01:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=VvXFBu+i7VzWN3y9TeljwKgLH0JzkfmZ84RtAj7Tic8=;
 b=GlzjP3bqSB9OzWyxAvTW1CHy35UinLZI2g2St+B+kVSxzxZmOgbsDwliB3w7cKcGLxam
 tNk3wgwhv/tzN5OmX32N548whGDWUvy7zTxRqdfJM5XJ+NZcVuSZC0G1bViwC2kzbfMx
 /psVEaTT4Y5ON71bhP5AomeytArlRFaFLKdfZzBCNqPn3rWPgcuUt2e60zmPBcf69gew
 Y8eZO/WFzkrHk4QHbx+cT3elj9xNSPsDOw4vdHthYKhwPi2Ru0m0j34cMJD4eIxy7nbD
 iZy60ZKu1knBH+xImbjOuuVhLXEashNEGqKVRmk1ceOL6GcSnfsU5ZzKoWv950nboXhI RQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4r70c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 01:17:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P1Dxj2027262;
        Fri, 25 Oct 2019 01:17:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vug0crt5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 01:17:51 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9P1Hg7I018493;
        Fri, 25 Oct 2019 01:17:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 18:17:42 -0700
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] [SCSI] esas2r: unlock on error in esas2r_nvram_read_direct()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191022102324.GA27540@mwanda>
Date:   Thu, 24 Oct 2019 21:17:40 -0400
In-Reply-To: <20191022102324.GA27540@mwanda> (Dan Carpenter's message of "Tue,
        22 Oct 2019 13:23:24 +0300")
Message-ID: <yq1h83xbp3f.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=949
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250011
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Dan,

> This error path is missing an unlock.

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
