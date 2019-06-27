Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB75799B
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 04:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfF0Cnn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 22:43:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41060 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfF0Cnn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 22:43:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R2XiJp057145;
        Thu, 27 Jun 2019 02:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Ya7y3/l9WYnlzcmzBMnGgWiZQsapCOPCR9d87Z0t7F4=;
 b=V7M3k5UZ4trF23X5VqAVKZwTokrJ4uu9RCrULZUp2XpG4L5P8aGmv6VAVx1200k6YLn4
 Suroz20oMyqy4ALTtsdKxo+qnYTUJY8tnf42oyr4Yc6XkAbI+VOjMRy+VRHLqRZD9eYk
 xRl387emnJLEztPJBsK+k9kc3VsGxK1m21p+99tRppO8YidouZtT0Ag8vyw4H0vEzzbn
 jABjBb+wunhcTCSlGsmJ0HjmKdeC8mTaOP8ECqdTvdR0u/viDaG3y1apQXxDmC0XSAXf
 PjD7I0P/L3us3dDdMmFtqatmBc1luXogl52UNmWEVFYl83VZT57IsQphEuDFQch/NNzR 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyqng6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 02:43:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R2fuhC071241;
        Thu, 27 Jun 2019 02:43:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f4s6r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 02:43:40 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R2hdYk025025;
        Thu, 27 Jun 2019 02:43:39 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 19:43:39 -0700
To:     Saurav Kashyap <skashyap@marvell.com>
Cc:     <martin.petersen@oracle.com>, <gbasrur@marvell.com>,
        <svernekar@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/6] bnx2fc: Update to the driver.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190624083000.23074-1-skashyap@marvell.com>
Date:   Wed, 26 Jun 2019 22:43:37 -0400
In-Reply-To: <20190624083000.23074-1-skashyap@marvell.com> (Saurav Kashyap's
        message of "Mon, 24 Jun 2019 01:29:54 -0700")
Message-ID: <yq1blyjlpd2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=730
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=782 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270030
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Saurav,

> This series fixes various issues reported by internal testing.  Kindly
> apply this series to scsi-queue at your earliest convenience.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
