Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837A32EA39
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 03:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfE3Bct (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 21:32:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54958 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3Bct (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 21:32:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1Ollt161524;
        Thu, 30 May 2019 01:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8BBUKWRvjao+5xpf63Zw6+A89qbh5+KdpMPXCAv8+CA=;
 b=pMgs7/iMXTIA6YbPbeAmWIvba2hRM8kf7o4Jb/ax+iMBAGnxedXdbpbeA1ncpZ5Vmo2w
 41TayxlbEiHTXnuyTGecrBtAGGG2IRKwQeveyijERZRKENEkG9y9cmV4xzngvG71TdDS
 PsPHzUrnYyP5hueobaCd25eRc/ajoMd0rU2fhG8Kt+A9X6re9s/vEe6jj5kx2wcHBxw7
 sxsfuGbfTdHfmSt+mgN4/d1a0yO8b2qDt0DlWbUx/jemvfMqmhgMqeY5wxMtDsri0MlF
 Zc52XQGaNKitaODXVgFADIUuBs3xHd7eNg0Mi2cjA9MDh4YGm6WLx+rRnYhg4RD49dhT pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2spxbqd4cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:32:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1VNXP068127;
        Thu, 30 May 2019 01:32:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ss1fnspqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:32:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U1WPGp003345;
        Thu, 30 May 2019 01:32:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 18:32:24 -0700
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/3] ibmvscsi: Wire up host_reset() in the drivers scsi_host_template
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190503005058.8768-1-tyreld@linux.ibm.com>
Date:   Wed, 29 May 2019 21:32:22 -0400
In-Reply-To: <20190503005058.8768-1-tyreld@linux.ibm.com> (Tyrel Datwyler's
        message of "Thu, 2 May 2019 19:50:56 -0500")
Message-ID: <yq17ea820d5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=951
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300009
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Tyrel,

> Wire up the host_reset function in our driver_template to allow a user
> requested adpater reset via the host_reset sysfs attribute.

Series applied to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
