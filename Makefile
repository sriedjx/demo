PORTNAME=	opentelemetry-collector
DISTVERSIONPREFIX=	v
DISTVERSION=	0.19.2
CATEGORIES=	sysutils
MAINTAINER=	vijay@gmail.com
COMMENT=	The OpenTelemetry Collector offers a vendor-agnostic implementation on how to receive, process and export telemetry data.

LICENSE=	APACHE20
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		gmake go:modules
USE_GITHUB=	yes
GH_ACCOUNT=     edjx

PLIST_FILES=	bin/otelcol

pre-build::show-info
show-info:
	@${ECHO_MSG} ""
	@${ECHO_MSG} "ATTENTION"
	@${ECHO_MSG} "---------------------------------------------------------------"
	@${ECHO_MSG} "---------------------------------------------------------------"
	@${ECHO_MSG} "Make sure GOPATH: /root/go And is added to PATH GOPATH/bin:PATH"
	@${ECHO_MSG} "---------------------------------------------------------------"
	@${ECHO_MSG} "---------------------------------------------------------------"

post-extract: 
	@${ECHO_MSG} ""
	@${ECHO_MSG} "---------------------------------------------------------------"
	@${ECHO_MSG} "POST EXTRACT"
	@${ECHO_MSG} "---------------------------------------------------------------"
	
do-build:
	cd ${WRKSRC} && HOME=${WRKDIR} PATH=${WRKDIR}/go/bin:${PATH} GO_NO_VENDOR_CHECKS=1 NO_LINT=YES  gmake install-tools
	cd ${WRKSRC} && HOME=${WRKDIR} PATH=${WRKDIR}/go/bin:${PATH} GO_NO_VENDOR_CHECKS=1 NO_LINT=YES  gmake otelcol
	cd ${WRKSRC}/bin && mv otelcol_freebsd_amd64 otelcol

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/otelcol ${STAGEDIR}${PREFIX}/bin/otelcol

.include <bsd.port.mk>
