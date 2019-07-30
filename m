Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2AC7AEF9
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jul 2019 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfG3RJc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 13:09:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33306 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfG3RJc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 13:09:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UH6Yrv059358;
        Tue, 30 Jul 2019 17:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=zoxY5i1KK7gEr+cs+DfNAHFLcFxnIeardz8X41qPnxA=;
 b=QW+llM2xWta6PYt5oybtLnBka2QevkmrK3qbVvIX6hQUn9lFRV/ULuMsDIjU0dFdEi9t
 tXHN9c5gWZD6bYXJQ8A+VQQrNCtr3Q/4tIHpSR7rLxF0gotPf4TZkBLcqypP8YK374tI
 CaY8RioPW6wberV4V7B/ihCMPkFoTRIyhl4VVVpRvBH3WfYu2uYO+R4XqfS6hcWQSl49
 knM4khHq+INY3QpQAu/fx8IXeDdTB2gheaGEdnQHPuDq4iDH4gBcuTB/vUjrtlNnz+l0
 /UAyMRENdWRaGK5GY06ubIOlX7SvLBElvhk9OkLle+R1ms+S04nV7qL+FrvO+7xtoa47 lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u0f8qytvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 17:08:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UH2lBD167232;
        Tue, 30 Jul 2019 17:08:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2u0xv8aj93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 17:08:13 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6UH8Bci024178;
        Tue, 30 Jul 2019 17:08:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 10:08:11 -0700
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: scsi_debugfs: Use for_each_set_bit to simplify code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190725200751.64570-1-andriy.shevchenko@linux.intel.com>
Date:   Tue, 30 Jul 2019 13:08:09 -0400
In-Reply-To: <20190725200751.64570-1-andriy.shevchenko@linux.intel.com> (Andy
        Shevchenko's message of "Thu, 25 Jul 2019 23:07:51 +0300")
Message-ID: <yq1ef27mow6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=874
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=941 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300178
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Andy,

> We can use for_each_set_bit() to slightly simplify the code.

Applied to 5.4/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
