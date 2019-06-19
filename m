Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060F44AF4E
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 03:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfFSBFg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 21:05:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50436 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSBFg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 21:05:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J144At105293;
        Wed, 19 Jun 2019 01:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=o1w6H5pPtHaXUVoxLoKQ7/jMGyJuBLlxxqmx8Pe3f6I=;
 b=NopabiXUefG3t4lvADt390XljzmdXWoXJveLd+lAThyRTVRvoPO4HT+zRnFN8B+Wy6ZI
 fjdlJwBzuNWKyMIZAJafFshOuHDtkC8cLHTWg9UUVk3Ddul15HQUHzpTjogPBriZDn9A
 5WMFhXH06yCZcyT8ReW03cidzA9Z5kO7WqaW6Adnp5dT0TtEUBcP4Tgki1K15/oHCJxj
 HXQixHZlBAtzs9nmXDw7f7YKOcKutm8zuqE9taWPzfybRjr42aI0i2RHYbEyUYjLdmTg
 fZXCrXxkzHBer7RGEVyQvrITgyUEDlhCnCcDPEVKKxI926XGNqZP5MiIctp9CZNQdaeQ Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t78098fh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:04:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J13a5C111162;
        Wed, 19 Jun 2019 01:04:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t77ymsxab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:04:57 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J14uRn019314;
        Wed, 19 Jun 2019 01:04:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 18:04:56 -0700
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     linux-scsi@vger.kernel.org, suganath-prabu.subramani@broadcom.com,
        kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com
Subject: Re: [PATCH 0/2] mpt3sas
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190614144144.6448-1-thenzl@redhat.com>
Date:   Tue, 18 Jun 2019 21:04:53 -0400
In-Reply-To: <20190614144144.6448-1-thenzl@redhat.com> (Tomas Henzl's message
        of "Fri, 14 Jun 2019 16:41:42 +0200")
Message-ID: <yq1k1dixu4q.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=657
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=714 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190007
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


> Just few small changes, octal numbers instead of constants etc.

Broadcom folks: Please review!

-- 
Martin K. Petersen	Oracle Linux Engineering
