Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BDC2EA12
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 03:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfE3BGE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 21:06:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44034 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfE3BGE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 21:06:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U0wnl5155209;
        Thu, 30 May 2019 01:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=NTAveDZ9fMDtdsyCRXbRE5K1ChRMvJsN1HL9prKmrAY=;
 b=M2RaxuT4iis2asiwctDqGUwMhwX7xA/S4beVJ0+AXXNiM1LZGj+MToQ7T8sMoavRtmaB
 r+8Ybq09IERdZqObEkeq40gazYgOo61pQPc93wWrLw5Z9NcBI4lECPTWa/rplQmljqBc
 3QZ7wCeVtQAySYwk3F6q1ymHgt6DZlrK8tlZhYImFPTPHrAeIcx6hMx9f21JuaAkoY79
 eS2YWc2dTHoDhGR1zf3xk/+EQWmjO4X9gNkl9bK/EjlRKPeP1iT4ekVLwWYvNnV8UcdX
 0efsDBEYqmdum9EVyZxonUuoDxlZVXpq73diSKiUF/xZLu8jJoOKrhGE4iIwSVB36BY/ 1w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dndhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:06:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U14OxE088845;
        Thu, 30 May 2019 01:06:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sqh741a5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:06:01 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U160Zq032235;
        Thu, 30 May 2019 01:06:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 18:06:00 -0700
To:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: Re: [PATCH v2 08/10] mpt3sas: Enable interrupt coalescing on high iops
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
        <20190520102604.3466-9-suganath-prabu.subramani@broadcom.com>
Date:   Wed, 29 May 2019 21:05:58 -0400
In-Reply-To: <20190520102604.3466-9-suganath-prabu.subramani@broadcom.com>
        (Suganath Prabu S.'s message of "Mon, 20 May 2019 06:26:02 -0400")
Message-ID: <yq1ftow21l5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=907
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=950 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300006
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Suganath,

> This configuration should reset during driver unload or shutdown to
> the default settings. For this driver takes copy of default ioc page 1
> and copy backs the default or unmodified ioc page1 during unload and
> shutdown. so that on next driver load (e.g. if older version driver is
> loaded by user), current modified changes on ioc page1 won't take
> effect.

What happens if the system crashes before the old page is put back?

-- 
Martin K. Petersen	Oracle Linux Engineering
