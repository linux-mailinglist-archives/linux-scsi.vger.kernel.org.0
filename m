Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363F7369C2
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 04:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFFCFq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 22:05:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55102 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFFCFq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 22:05:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5625Dss124563;
        Thu, 6 Jun 2019 02:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=NX5cH1V3dLXcMi9Tv/iqE0k/Mhdpf9u0wFy0hYpkKAk=;
 b=Bi0L9DGlMlfnFYxMZotIRopZVf6FqtOE+yiVLGuq7LnW61y+HC2qn32u55cSVWt8qAjz
 i2O8/srKy+bwlx0CxXkXf5Kbm90yYqsKy3xh5wapXN2U3T10Ln6F6DWHQbNmXihOQxkA
 B3vBcjj9dZ1Ea4mxKyeehOcVXrYHirVwke65MBXR+edLNqGmo6Qmm/vUqwyKvpvVX580
 t+EWVh1CP4qte3+Lkr/UMUzKMSpXfdpbhOZ/tG4WekDJfHWf9lAon8ZAW67uAy7ZGLMc
 EfAt5sc4YYi3BrJFLmz3sNA+kjC8R+1E5zTKERismDId3UkQVPIHXI+0om33XLl2kohL XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2suj0qnnn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 02:05:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5623t6L125294;
        Thu, 6 Jun 2019 02:05:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2swngj6dwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 02:05:30 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5625O2c021565;
        Thu, 6 Jun 2019 02:05:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2019 19:05:24 -0700
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 00/20] qla2xxx Patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190529202826.204499-1-bvanassche@acm.org>
        <794547A0-2D81-42DD-8777-27B9BE607E21@marvell.com>
Date:   Wed, 05 Jun 2019 22:05:22 -0400
In-Reply-To: <794547A0-2D81-42DD-8777-27B9BE607E21@marvell.com> (Himanshu
        Madhani's message of "Wed, 29 May 2019 21:44:29 +0000")
Message-ID: <yq1y32fo4d9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=784
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9279 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=839 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060014
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu,

> Thanks for the series. We will provide ACK after these patches have
> gone through our internal testing.

Ping on this series. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
