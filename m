Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A2138D0C
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfFGOaz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 10:30:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52420 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfFGOaz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 10:30:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57ENXEK038218;
        Fri, 7 Jun 2019 14:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=vHWoLagVBmv0v/6C38klOObnaPCRgMIVLR5AWPO8avw=;
 b=PqCBSJ4RLs+TIwP5yryU1A5JRr58zvtR15N9d2mIpR2rrg/ufTqALQtIpjIJxfSik6IM
 qnfQddBkW9we7fACIjoWwhz8+d2JH3Ws3PYV8mRwB7iGunXFWT4kjCfuImwIOkBrKIoJ
 dwTDiGRrnF8+wZLspFKE+5tMao0Oiwp73tTkBvRD/rk71mCKqc7zpIPWqbO3JBBk9BbX
 l7bxQyYzCQk65EgAagTCHPgyodnGa6zjLHR/QPr+SDm0ipRD0zxB5J2JxLk2yZZJQUja
 NvXEKbUrU7RzI+SQzqOa+QTQzQA6RIbKyQMPPMw1TUpSL0WeNryJNHexyiD6aLb0UznT Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2suevdxvbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 14:30:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57ET780020972;
        Fri, 7 Jun 2019 14:30:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2swngn3vd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 14:30:51 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57EUoWC015518;
        Fri, 7 Jun 2019 14:30:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 07:30:49 -0700
To:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com
Subject: Re: [V3 00/10] mpt3sas: Aero/Sea HBA feature addition
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
Date:   Fri, 07 Jun 2019 10:30:47 -0400
In-Reply-To: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
        (Suganath Prabu S.'s message of "Fri, 31 May 2019 08:14:33 -0400")
Message-ID: <yq1r285jwmg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=528
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=592 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070102
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Suganath,

I applied this series to 5.3/scsi-queue.

However, I remain unconvinced of the merits of the config page
putback. Why even bother if a controller reset causes the defaults to be
loaded from NVRAM?

Also, triggering on X86 for selecting performance mode seems
questionable. I would like to see a follow-on patch that comes up with a
better heuristic.

-- 
Martin K. Petersen	Oracle Linux Engineering
