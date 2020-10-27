Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D6729A271
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Oct 2020 02:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504303AbgJ0B4n (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Oct 2020 21:56:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53274 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436576AbgJ0B4m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 26 Oct 2020 21:56:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R1ngvH038172;
        Tue, 27 Oct 2020 01:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=xoXbMTBzUmyUEogdN/xN/rvttckAEzghlO7QwtnvLrs=;
 b=gM0i+Dvp7FFNB4pemaL1YXPlIm+m47NCsl7PE29gthMTwFOI6qIYZMkE9CSGrEEzRfVz
 gFd5UAHWXSJgjyXhy4n1/f4Q1O6kEJDFMOoSZkz+e70w4Tk8+1JNgygLuJRfIDz9AJzw
 BXeBkQYIc8wMJWdlcE01cyxeuRmoVW3TDfLXpJ/kSCbUHXDtd31JVxUAEQM5olRLzes9
 RSJnOxgZRJOLiN+bFOZU8v4XKHK8UEd3nZuekSUR5cwWZMENDr5uA7fCq1letrJmOgPS
 Gph7bPP0+qMalcsyucBgNY/f9K+NkkHKs08qaxot1EQO7ikAdXVp8sf0Zr0vwVxRHF8S tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34c9saqmh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 01:56:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R1u0A7064402;
        Tue, 27 Oct 2020 01:56:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34cx5wje9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 01:56:33 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09R1uTeh023758;
        Tue, 27 Oct 2020 01:56:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 18:56:29 -0700
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com
Subject: Re: [PATCH] ibmvfc: add new fields for version 2 of several MADs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v9ew4ekf.fsf@ca-mkp.ca.oracle.com>
References: <20201026013649.10147-1-tyreld@linux.ibm.com>
Date:   Mon, 26 Oct 2020 21:56:25 -0400
In-Reply-To: <20201026013649.10147-1-tyreld@linux.ibm.com> (Tyrel Datwyler's
        message of "Sun, 25 Oct 2020 20:36:49 -0500")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=1
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270012
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Tyrel,

> Introduce a targetWWPN field to several MADs. Its possible that a scsi
> ID of a target can change due to some fabric changes. The WWPN of the
> scsi target provides a better way to identify the target. Also, add
> flags for receiving MAD versioning information and advertising client
> support for targetWWPN with the VIOS. This latter capability flag will
> be required for future clients capable of requesting multiple hardware
> queues from the host adapter.

Applied to 5.11/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
