Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A67012F383
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jan 2020 04:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgACDXv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Jan 2020 22:23:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45340 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgACDXv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 Jan 2020 22:23:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0033IrIq098927;
        Fri, 3 Jan 2020 03:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=rKhj7FKgCQwsbYwebX++RNGlDbBj7B4ZPz04H287Xnw=;
 b=G/1g3w0UFjfwwy4P396bcrxuW0o/J1Q44poab6/YnfKdD9Yz2HjfZKNL21eskjqbqX82
 q5nCx9+9rpurvIEZf1puJnm6048gfOXkQL2tSGA+V1Oz+3b2oRImk41JuSz+O2Pjoa72
 ObVpLw3ngFkT2snsuEs6Rj3VSeK5/0SZh5SsYStkwLGfkx8vpd4Q1AKl+NIuAgbAEEH4
 XeGIr/XKqqtNntsaj9cOMawOGrM7fyotQTLqaHRGnS2dRHVfcczJk+mQHyI8nITpmJ3X
 +t5Lq5fgnaLHQ/DPVewlNjQfFBPiGpFRhlIMOUTihLes5Nmdoi/IeZhlNg524DaeSNTE uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2x5ypqtbe2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 03:23:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0033NFgm041970;
        Fri, 3 Jan 2020 03:23:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2x8gjbc1yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 03:23:47 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0033NkCm000877;
        Fri, 3 Jan 2020 03:23:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jan 2020 19:23:45 -0800
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        suganath-prabu.subramani@broadcom.com, sathya.prakash@broadcom.com
Subject: Re: [PATCH v1 00/10] mpt3sas: Enhancements of phase14
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191226111333.26131-1-sreekanth.reddy@broadcom.com>
Date:   Thu, 02 Jan 2020 22:23:43 -0500
In-Reply-To: <20191226111333.26131-1-sreekanth.reddy@broadcom.com> (Sreekanth
        Reddy's message of "Thu, 26 Dec 2019 06:13:23 -0500")
Message-ID: <yq1o8vl4400.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=795
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001030031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=855 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001030030
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Sreekanth,

> Below are the main features are added in this patch set.

Applied to 5.6/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
