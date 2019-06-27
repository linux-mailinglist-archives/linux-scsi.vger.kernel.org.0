Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21AD957A7E
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 06:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF0EMb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Jun 2019 00:12:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47942 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0EMb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Jun 2019 00:12:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R492Gm029456;
        Thu, 27 Jun 2019 04:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ZZpIUDVKJ3j4zd5d3+1JbJ6aX4Ws8PmIK4ZqoqhYU80=;
 b=kXbxWXqfL7vgmHehV9J4M19D7X7MGOifP7S3n4IWDblKCYPD8A/wTX9GeMxG0fYCEJZI
 oTuKUsCsMsAK0dqQqrWFoAQYIBg61Rfj2SxVmreiJM7Yf5eBKbXvmNJNA4ZrYM24Iz9Y
 BfGs5dm4W/Y5/kK7qnX02SccFfc+/F2iNXyYrL39VQ3jwl/35kj3YEJhpsunDxnLwUfn
 H8w+5TISnRlZNWGPl02tHWYZjIYYPa7N8lOKapmNNbma7pkjrbPVK6LrLlGlBTMDVXL0
 8u89gp4PDUTgkHKliCzWMXtedOSYV6Jv3YFRpsif7LTv19B3MtXb5Yn1UhMdgPvpWa9Z UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9pwrfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 04:12:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R4BSGQ077413;
        Thu, 27 Jun 2019 04:12:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7d5h03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 04:12:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R4CQJk002997;
        Thu, 27 Jun 2019 04:12:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 21:12:26 -0700
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/1] qla2xxx: move IO flush to the front of NVME rport unregistration
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190616150553.28399-1-hmadhani@marvell.com>
Date:   Thu, 27 Jun 2019 00:12:24 -0400
In-Reply-To: <20190616150553.28399-1-hmadhani@marvell.com> (Himanshu Madhani's
        message of "Sun, 16 Jun 2019 08:05:53 -0700")
Message-ID: <yq17e97k6on.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=490
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=557 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270046
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu,

> On session deletion, current qla code would unregister an NVMe session
> before flushing IOs. This patch would move the unregistration of NVMe
> session after IO flush. This way FC-NVMe layer would not have to wait
> for stuck IOs. In addition, qla2xxx would stop accepting new IOs
> during session deletion.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
