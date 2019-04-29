Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A668FEBFA
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 23:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfD2VO7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 17:14:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54406 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfD2VO6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 17:14:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TL4Ttc063621;
        Mon, 29 Apr 2019 21:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=yRRIgrKmGEbGyxjXNKbz5uikadxVwBst5opDzOMPro8=;
 b=ZBFtGUzIpl4sTkepUPGUmYj28nQFgTjhK/PuvawGeBQIzk4OyzKg/zZ/MsfZcYy2mxIX
 8Hmnkw68sVu3TiLLdP+yfm5XYDABpNvzXv9F23nqjShIgRnBn/JTpWu2n1KOoWLTJFUt
 8aDZxzPoBasi+cyD26phqLnsl/lU1TWvsBuCskCE2tboqeDgbuTsd6ILlX0FF9x2gE2Y
 St0qSBjO1BLT8pED0st6QC4yDQvnxieAb+7rgVbmZWWi6UYH5j7aD6qMvavX0aYBTwsQ
 4e6Jdm3ZhXCpIEucpYX6I3x7QfoAJ6v0Y1PBG+dL8t+bY+R67I1JJCSf/rGWWgSJfshh mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2s5j5twnxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 21:14:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TLD1Gi042220;
        Mon, 29 Apr 2019 21:14:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2s5u50mfcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 21:14:46 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3TLEhNG005556;
        Mon, 29 Apr 2019 21:14:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 14:14:43 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] Revert the patches that rework sd probing
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190429182153.206292-1-bvanassche@acm.org>
Date:   Mon, 29 Apr 2019 17:14:41 -0400
In-Reply-To: <20190429182153.206292-1-bvanassche@acm.org> (Bart Van Assche's
        message of "Mon, 29 Apr 2019 11:21:51 -0700")
Message-ID: <yq1r29ky0n2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=675
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290137
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=720 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290137
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Bart,

> For a not yet fully root-caused reason patch "sd: Rely on the driver
> core for asynchronous probing" causes trouble with suspend/resume.

Sad about this.

> Since not much time is left before the merge window opens, revert this
> patch and also a patch that depends on it.

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
