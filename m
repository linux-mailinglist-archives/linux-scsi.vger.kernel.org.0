Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAE954D0
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Aug 2019 05:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfHTDIG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Aug 2019 23:08:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35314 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbfHTDIG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Aug 2019 23:08:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7K34AH0188524;
        Tue, 20 Aug 2019 03:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=MUDLO1plg/5qdsM9WdnJDubOw8HUgWnMucOmTomFapI=;
 b=SCAf/PR3xSUB6lDtHHIQOIc4kY/RvFdcT+Sr1Auu8ttZO7fDUHmgR1tJ9g0PoWSrxs7+
 ulu3DmqN2ZxXAmNKwc7hnAhXBFXJvLEwRv2NgbXbvY/Y5MJSU48aOvHblC6LETTEDCL0
 mXz6QAAoKmy1PsEAFtZdazOCfV6SNEgizQmsYdbw2ud2Wrmj44FF6uV72NvVCiDOvCYF
 Ba4ao1qnjcymnFEpgamyluOdF0FCHWD312D1pT/HlZQ34AGPwZn5cfm5tjf2+H7eKZop
 LfXw2l1nsillTo3JUbYQlKQOLKh1z+eEaAtnhm13isM6Zpbxpm3RhW7WZ7rXcuptIr5i xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2uea7qk3r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 03:08:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7K33IBx061175;
        Tue, 20 Aug 2019 03:06:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ug2682qvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 03:06:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7K363Co020089;
        Tue, 20 Aug 2019 03:06:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Aug 2019 20:06:03 -0700
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH 00/42] lpfc: Update lpfc to revision 12.4.0.0
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190814235712.4487-1-jsmart2021@gmail.com>
Date:   Mon, 19 Aug 2019 23:06:01 -0400
In-Reply-To: <20190814235712.4487-1-jsmart2021@gmail.com> (James Smart's
        message of "Wed, 14 Aug 2019 16:56:30 -0700")
Message-ID: <yq1r25gy1ra.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=766
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908200028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=836 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908200028
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


James,

> Update lpfc to revision 12.4.0.0

Applied to 5.4/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
