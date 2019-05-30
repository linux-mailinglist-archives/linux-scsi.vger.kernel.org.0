Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591F82EA5D
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 03:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfE3Bti (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 21:49:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47908 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3Bti (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 21:49:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1mWj9187282;
        Thu, 30 May 2019 01:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=tdx3e6QTVXuxsk5qFlWipvtWnAc0EVgIebGZzRMOLFw=;
 b=ZCY/ksm+JsXf1hArKPLw/2s4HSrTHCa97dMsckFXzwJHieZvCKJcW42lPsI0ld31dYdg
 Aj55P4eWWSP7an6S+MTcxo4+VFHyfLS8wslv/cArkrPA8vdhsGTQTPpVaAs3aBymWsAH
 /8t4eT1mwPy5RXQxhZl5Po3eoe0pE56/om+6J6IVyKiXtPJseCVPIpblyGuMFZN5OrAh
 G2YHEl2HAvumY34Pd4Tptt8CxxhgP4fhXY64i7Lkpvwb6BYtH+OivUOQdL0iXvpgvg31
 NGjHzFRlyf6H4A9aKbgRfwSd9RygBaA58rSwGd4mdeDoqr4+r7RDntVMkHEzprHNbqV2 iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7dnggf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:49:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1m6pE163314;
        Thu, 30 May 2019 01:49:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2sr31vkcdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:49:32 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U1nVZo012519;
        Thu, 30 May 2019 01:49:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 18:49:31 -0700
To:     Varun Prakash <varun@chelsio.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        dt@chelsio.com, indranil@chelsio.com, ganji.aravind@chelsio.com
Subject: Re: [PATCH] scsi: libcxgbi: add a check for NULL pointer in cxgbi_check_route()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1558536055-5974-1-git-send-email-varun@chelsio.com>
Date:   Wed, 29 May 2019 21:49:29 -0400
In-Reply-To: <1558536055-5974-1-git-send-email-varun@chelsio.com> (Varun
        Prakash's message of "Wed, 22 May 2019 20:10:55 +0530")
Message-ID: <yq1h89czp7a.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=842
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=881 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300012
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Varun,

> ip_dev_find() can return NULL so add a check for NULL pointer.

Applied to 5.2/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
