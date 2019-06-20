Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9154DB38
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 22:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFTU3L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 16:29:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43706 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfFTU3L (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 16:29:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KKOLBg037448;
        Thu, 20 Jun 2019 20:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=R1QztK9Xzb/NxHh+PFnyE5NZa0sUHamt0f9qc51ph/c=;
 b=wFfSz2sVS3SvBcu0gqz5AWzn7U4iarU5vo/CapDVgnUcVN85P9W9X6VgK1EI82ez8h4Z
 DuLKSDzYMXGiCjA3lXpLDB9oE4ggTdXgyQachznB/NAh/7RWY11HQWk6kS4PzkYRRD5x
 z1lZicljgAcm5xldfpyiQ9EJ0N3Pw0mI1t45pn6LsuBJHSYARPQSV9ULaKKalPzjS3IL
 9knzCZ6mUkhOP1u8ggEv4Uk0iUzG1AoWvfPw5p+vuIwPjsUtp8MWdNyGSZFJzgTEhi5+
 tFhSB88CBxZOzdSrwlUXu13APfbIAZnXYObmEv1IFzTd34tyhAaYXmAKQ+ncHRLdl2gF Jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t7809k5ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:28:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KKRhnj192118;
        Thu, 20 Jun 2019 20:28:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t77yntskk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:28:47 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5KKSkNW022442;
        Thu, 20 Jun 2019 20:28:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 20:28:46 +0000
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     linux-scsi@vger.kernel.org, suganath-prabu.subramani@broadcom.com,
        kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com
Subject: Re: [PATCH 0/2] mpt3sas
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190614144144.6448-1-thenzl@redhat.com>
Date:   Thu, 20 Jun 2019 16:28:44 -0400
In-Reply-To: <20190614144144.6448-1-thenzl@redhat.com> (Tomas Henzl's message
        of "Fri, 14 Jun 2019 16:41:42 +0200")
Message-ID: <yq1d0j8rog3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=670
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=721 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200146
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Tomas,

> Just few small changes, octal numbers instead of constants etc.

Applied to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
