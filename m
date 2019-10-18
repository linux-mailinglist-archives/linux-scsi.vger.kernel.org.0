Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C98CDC197
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Oct 2019 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392529AbfJRJot (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Oct 2019 05:44:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46260 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392499AbfJRJot (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Oct 2019 05:44:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I29HX3114899;
        Fri, 18 Oct 2019 02:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=r8xMHrRuK5Y1PxrpLbIITk2rCEpFMSdDb3fo5A+lTyM=;
 b=X/0ewqaWgL4dm5xWm7ghZTajIT+fg2vHKvXWkJkacMj9g1V2dLkaMpuk+/4FiYB0qc+A
 GU52xF6o664DsLJcNpyR1iTjYG0zHPDB8zp5MFaFLfzUalF3Ed/HPIMenyr8foUMr5cy
 oiF9AgfQr8AfrWYVmNi2x0+5eWWtzsI3IJ1mTehQjP2p7gQACZV/WfUE4itgHrNVldAK
 kEmGeTf3YpS0c51kWOwA4RtaCrvWsU06XxYsOpvT7urTCMhwWl2UyYeett6o6hza+Ai3
 Cs0TFdK02uH2Ye+SC/b5UrJ/F1j6gOoqGCIto25n659kQ0Kg0LpRXBQPd8O7EbUqZ8+q tA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vq0q40s36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 02:12:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I23c6D192908;
        Fri, 18 Oct 2019 02:12:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vq0dwcfed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 02:12:09 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9I2C67o009023;
        Fri, 18 Oct 2019 02:12:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 02:12:06 +0000
To:     zhengbin <zhengbin13@huawei.com>
Cc:     <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: Re: [PATCH v4 1/2] sr: need to check whether sshdr is valid in sr_do_ioctl
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1571293177-117087-1-git-send-email-zhengbin13@huawei.com>
        <1571293177-117087-2-git-send-email-zhengbin13@huawei.com>
Date:   Thu, 17 Oct 2019 22:12:02 -0400
In-Reply-To: <1571293177-117087-2-git-send-email-zhengbin13@huawei.com>
        (zhengbin's message of "Thu, 17 Oct 2019 14:19:36 +0800")
Message-ID: <yq1a79ykdjh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=537
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=636 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180020
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


zhengbin,

> Like other callers of scsi_execute(send_trespass_cmd, hp_sw_tur...),
> we need to check whether sshdr is valid.

Applied to 5.4/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
